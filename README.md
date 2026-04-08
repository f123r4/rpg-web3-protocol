⚔️ Protocolo RPG Web3 - Filipe Meira Mazon
Este projeto implementa um ecossistema descentralizado para um jogo de RPG, utilizando contratos inteligentes na rede Ethereum (Sepolia).

🚀 Funcionalidades
DragonCoin (DGC): Token ERC-20 para economia do jogo.

RelíquiasRPG (NFT): Itens com mintagem dinâmica via Oráculo Chainlink (Preço fixo em $5 USD).

Staking: Contrato seguro com ReentrancyGuard para rendimento de recompensas.

Governança: DAO baseada em posse de tokens para votação de melhorias.

🛠️ Tecnologias Utilizadas
Solidity 0.8.24 (Hardhat / Ignition)

OpenZeppelin (Segurança e Padrões)

Chainlink Data Feeds (Preço em tempo real)

Python (Web3.py) (Integração Backend)

Slither (Auditoria Estática)

📋 Como Compilar
Instale as dependências: npm install

Compile os contratos: npx hardhat compile

Execute a auditoria: slither .