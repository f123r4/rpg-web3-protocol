// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Precisamos saber o saldo do jogador para calcular o "peso" do voto dele
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RPGGovernance {
    IERC20 public tokenDoJogo;

    // A estrutura de uma votação (ex: "Aumentar o dano da espada?")
    struct Proposta {
        string descricao;
        uint256 votosSim;
        uint256 votosNao;
        mapping(address => bool) jaVotou; // Impede o jogador de votar duas vezes
    }

    uint256 public numeroDePropostas;
    mapping(uint256 => Proposta) public propostas;

    // Eventos para o servidor do jogo saber o que está a acontecer
    event PropostaCriada(uint256 id, string descricao);
    event VotoRegistado(uint256 id, address eleitor, bool votoSim, uint256 pesoDoVoto);

    // Quando criamos a DAO, dizemos qual é a moeda oficial dos votos
    constructor(address _enderecoDoToken) {
        tokenDoJogo = IERC20(_enderecoDoToken);
    }

    // Função para qualquer jogador com moedas criar uma nova votação
    function criarProposta(string memory _descricao) external {
        require(tokenDoJogo.balanceOf(msg.sender) > 0, "Erro: Precisas de moedas para fazer uma proposta");
        
        Proposta storage novaProposta = propostas[numeroDePropostas];
        novaProposta.descricao = _descricao;
        novaProposta.votosSim = 0;
        novaProposta.votosNao = 0;

        emit PropostaCriada(numeroDePropostas, _descricao);
        numeroDePropostas++; // Prepara o ID para a próxima proposta
    }

    // Função para os jogadores votarem
    function votar(uint256 _idProposta, bool _votoSim) external {
        require(_idProposta < numeroDePropostas, "Erro: Esta proposta nao existe");
        
        Proposta storage p = propostas[_idProposta];
        require(!p.jaVotou[msg.sender], "Erro: Tu ja votaste nesta proposta");
        
        // O peso do voto é exatamente a quantidade de moedas que o jogador tem
        uint256 pesoDoVoto = tokenDoJogo.balanceOf(msg.sender);
        require(pesoDoVoto > 0, "Erro: Nao tens moedas para votar");

        // Regista os votos e marca que este jogador já votou
        if (_votoSim) {
            p.votosSim += pesoDoVoto;
        } else {
            p.votosNao += pesoDoVoto;
        }

        p.jaVotou[msg.sender] = true;
        emit VotoRegistado(_idProposta, msg.sender, _votoSim, pesoDoVoto);
    }
}
