// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Safe Math Interface para realizar operacoes matematicas seguras como soma, subtracao, etc.
contract SafeMath {
    // Funcao de soma segura, que evita overflow (estouro de valor maximo)
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a, "Overflow na soma");
    }

    // Funcao de subtracao segura, que evita underflow (estouro de valor minimo)
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a, "Underflow na subtracao");
        c = a - b;
    }

    // Funcao de multiplicacao segura, que evita overflow
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b, "Overflow na multiplicacao");
    }

    // Funcao de divisao segura, que evita divisao por zero
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0, "Divisao por zero");
        c = a / b;
    }
}

// Interface do padrao ERC20 para a definicao das funcoes do token
interface ERC20Interface {
    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);
    function transfer(address to, uint tokens) external returns (bool success);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);
    
    // Eventos para emitir quando ocorre uma transferencia e quando uma aprovacao e feita
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

// Contrato principal do token MIDToken
contract MIDToken is ERC20Interface, SafeMath {
    string public symbol;    // Simbolo do token
    string public name;      // Nome do token
    uint8 public decimals;   // Decimais (comum em tokens ERC20)
    uint public _totalSupply; // Total de tokens emitidos

    // Mapeamento de enderecos para saldos
    mapping(address => uint) balances;

    // Mapeamento de enderecos para quantidades permitidas de gasto por terceiros
    mapping(address => mapping(address => uint)) allowed;

    // Constructor para definir nome, simbolo, decimais e supply inicial
    constructor() {
        symbol = "MID";  // Define o simbolo do token
        name = "MIDToken";  // Define o nome do token
        decimals = 18;  // Definindo 18 casas decimais (padrao em ERC20)

        // Define o total de tokens para 500 com 18 casas decimais
        _totalSupply = 500 * 10 ** uint(decimals);
        
        // O saldo inicial sera atribuido ao criador do contrato (msg.sender)
        balances[msg.sender] = _totalSupply;

        // Emite um evento de transferencia indicando a emissao inicial
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    // Funcao que retorna o total de tokens, excluindo tokens queimados (enviados para o endereco 0)
    function totalSupply() external view override returns (uint) {
        return _totalSupply;
    }

    // Funcao que retorna o saldo de uma conta especifica
    function balanceOf(address tokenOwner) external view override returns (uint balance) {
        return balances[tokenOwner];
    }

    // Funcao que transfere tokens do remetente para outro endereco
    function transfer(address to, uint tokens) external override returns (bool success) {
        require(tokens <= balances[msg.sender], "Saldo insuficiente");
        
        // Subtrai os tokens do remetente e os adiciona ao destinatario
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);

        // Emite um evento de transferencia
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    // Funcao para aprovar um 'spender' (gastador) para usar uma quantidade de tokens
    function approve(address spender, uint tokens) external override returns (bool success) {
        allowed[msg.sender][spender] = tokens;  // Define o valor permitido para o 'spender'
        emit Approval(msg.sender, spender, tokens);  // Emite o evento de aprovacao
        return true;
    }

    // Funcao que transfere tokens de uma conta para outra, se previamente aprovado
    function transferFrom(address from, address to, uint tokens) external override returns (bool success) {
        require(tokens <= balances[from], "Saldo insuficiente");
        require(tokens <= allowed[from][msg.sender], "Tokens permitidos insuficientes");

        // Atualiza os saldos de acordo com a transferencia
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        
        // Emite um evento de transferencia
        emit Transfer(from, to, tokens);
        return true;
    }

    // Funcao que retorna o valor que um 'spender' pode gastar em nome de um proprietario de tokens
    function allowance(address tokenOwner, address spender) external view override returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }
}
