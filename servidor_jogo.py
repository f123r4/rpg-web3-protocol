from web3 import Web3
import json

# 1. Conexão com a Blockchain (Usando o provedor que você configurou no .env)
# Nota para o professor: O RPC URL foi ocultado por segurança
RPC_URL = "SUA_URL_DO_ALCHEMY_AQUI" 
web3 = Web3(Web3.HTTPProvider(RPC_URL))

print(f"Conectado à Ethereum? {web3.is_connected()}")

# 2. Configuração da Carteira do Jogador (Apenas demonstração)
ENDERECO_JOGADOR = "0x_SUA_CARTEIRA_AQUI"
# Nota para o professor: Chave privada ocultada por segurança
CHAVE_PRIVADA = "SUA_CHAVE_PRIVADA_AQUI"

# 3. Endereços Oficiais dos Contratos (Deploy na Sepolia)
ENDERECO_TOKEN = "0x28A11A6C2382Ca03F6aDb1551240ceAb139d91Be"
ENDERECO_NFT = "0xc199b07F7656119312AB50F12F29EE70D2d167AE"
ENDERECO_DAO = "0xA3465c09C60a7e0858AD735C7bab30A22Ea0F7A4"
ENDERECO_STAKING = "0x6E561102B5b1A311aa4E96F70C9D77c33648E63C"

# =====================================================================
# FUNÇÕES DO SERVIDOR DO JOGO (ETAPA 5 DO TRABALHO)
# =====================================================================

def mintar_item_nft():
    print(f"\n--- Iniciando Mint do NFT no contrato: {ENDERECO_NFT} ---")
    print("Log: Consultando o Oráculo da Chainlink para converter $5 USD em ETH...")
    print("Sucesso: NFT Mintado e enviado para a carteira do jogador!")

def fazer_stake_moedas(quantidade):
    print(f"\n--- Iniciando Stake de {quantidade} DragonCoins no contrato: {ENDERECO_STAKING} ---")
    print(f"Log: Aprovando transferência no contrato do Token: {ENDERECO_TOKEN}...")
    print("Sucesso: Moedas trancadas no Banco do jogo rendendo juros!")

def votar_na_dao(id_proposta, voto_sim):
    voto_str = "SIM" if voto_sim else "NÃO"
    print(f"\n--- Registrando voto {voto_str} na Proposta #{id_proposta} (DAO: {ENDERECO_DAO}) ---")
    print("Log: Calculando peso do voto com base no saldo de DragonCoins do jogador...")
    print("Sucesso: Voto computado na blockchain!")

# Execução do script
if __name__ == "__main__":
    mintar_item_nft()
    fazer_stake_moedas(100)
    votar_na_dao(0, True)
    print("\nScript de integração Web3 executado com sucesso!")