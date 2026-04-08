// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Interface para interagir com o nosso token ERC-20 (DragonCoin)
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// Segurança exigida na Etapa 3 do PDF: Proteção contra ataque de Reentrância
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract RPGStaking is ReentrancyGuard {
    IERC20 public stakingToken;

    // Dicionários para guardar quanto cada jogador depositou e a hora exata
    mapping(address => uint256) public balances;
    mapping(address => uint256) public lastStakeTime;

    // O construtor vincula este contrato ao endereço da nossa moeda
    constructor(address _stakingToken) {
        stakingToken = IERC20(_stakingToken);
    }

    // Função para trancar as moedas no banco (Stake)
    // O 'nonReentrant' é a trava mágica de segurança contra hackers
    function stake(uint256 amount) external nonReentrant {
        require(amount > 0, "Erro: Nao pode depositar zero");
        
        // Puxa as moedas da carteira do jogador para o contrato do banco
        require(stakingToken.transferFrom(msg.sender, address(this), amount), "Falha na transferencia");
        
        // Atualiza o saldo e grava a hora do deposito
        balances[msg.sender] += amount;
        lastStakeTime[msg.sender] = block.timestamp;
    }

    // Função para o jogador sacar o depósito inicial + as recompensas
    function withdraw() external nonReentrant {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Erro: Nenhum saldo em stake");

        // Calcula quanto tempo passou desde o depósito
        uint256 tempoPassado = block.timestamp - lastStakeTime[msg.sender];
        
        // Para testes práticos e rápidos, vamos render 10% a cada 1 minuto
        uint256 minutosPassados = tempoPassado / 60;
        uint256 recompensa = (amount * 10 / 100) * minutosPassados;

        // SEGURANÇA: Sempre zeramos o saldo ANTES de enviar o dinheiro
        balances[msg.sender] = 0;

        // Devolve o valor original mais o lucro
        require(stakingToken.transfer(msg.sender, amount + recompensa), "Falha no saque");
    }
}
