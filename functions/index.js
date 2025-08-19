// functions/index.js

const { onCall } = require("firebase-functions/v2/https");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");

initializeApp();

/**
 * Recebe a estratégia de um jogador para um duelo específico.
 * @param {object} data O objeto de dados da chamada.
 * @param {string} data.duelId O ID do documento do duelo.
 * @param {object} data.strategy O objeto contendo a estratégia do jogador.
 * @param {object} context O contexto da chamada, incluindo informações de autenticação.
 * @returns {object} Um objeto indicando o sucesso da operação.
 */
exports.submitStrategy = onCall(async (request) => {
  // Valida se o usuário está autenticado
  if (!request.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Você precisa estar logado para enviar uma estratégia.",
    );
  }

  const { duelId, strategy } = request.data;
  const uid = request.auth.uid;

  if (!duelId || !strategy) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Dados inválidos. É necessário fornecer duelId e strategy.",
    );
  }

  const firestore = getFirestore();
  const duelRef = firestore.collection("duels").doc(duelId);

  // Atualiza o documento do duelo com a estratégia do jogador
  // O caminho `players.${uid}.strategy` usa o UID do jogador para garantir
  // que ele só possa atualizar sua própria estratégia.
  await duelRef.update({
    [`players.${uid}.strategy`]: strategy,
    [`players.${uid}.hasSubmitted`]: true,
  });

  // Lógica futura: verificar se todos os jogadores enviaram para
  // processar a rodada e calcular os pontos.

  return { success: true, message: "Estratégia recebida com sucesso!" };
});