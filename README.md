# MID Token

## Descrição

O **MID Token** é um token ERC-20 criado na blockchain Ethereum. Este contrato permite a criação, transferência e gerenciamento de tokens digitais. O contrato implementa funcionalidades básicas de um token, como transferência, aprovação e consulta de saldo.

## Funcionalidades

- **Soma e subtração seguras**: Utiliza operações matemáticas seguras para evitar overflow e underflow.
- **Implementação do padrão ERC-20**: Inclui as funções padrão necessárias para um token ERC-20, como `transfer`, `approve`, `transferFrom`, `balanceOf` e `allowance`.
- **Eventos**: Emite eventos de `Transfer` e `Approval` para registrar operações de transferência e aprovações.

## Estrutura do Contrato

### SafeMath

Um contrato auxiliar que fornece funções de adição, subtração, multiplicação e divisão seguras.

### ERC20Interface

Define a interface padrão para a implementação do token ERC-20.

### MIDToken

O contrato principal do token que herda da `SafeMath` e implementa a interface `ERC20Interface`.

## Funções Principais

- `totalSupply()`: Retorna o total de tokens emitidos.
- `balanceOf(address tokenOwner)`: Retorna o saldo de um determinado proprietário de tokens.
- `transfer(address to, uint tokens)`: Transfere uma quantidade de tokens de uma conta para outra.
- `approve(address spender, uint tokens)`: Aprova um gastador para usar uma quantidade específica de tokens.
- `transferFrom(address from, address to, uint tokens)`: Permite que um gastador transfira tokens de um proprietário para outro.
- `allowance(address tokenOwner, address spender)`: Retorna a quantidade de tokens que um gastador pode usar em nome de um proprietário.

## Como Compilar e Implantar

1. Certifique-se de que você tenha o **Remix IDE** instalado.
2. Copie o código do contrato para um novo arquivo no Remix.
3. Selecione a versão do compilador Solidity 0.8.7 ou superior.
4. Compile o contrato.
5. Na aba "Deploy & Run Transactions", selecione a conta do remetente e clique em "Deploy".
6. Aguarde a transação ser confirmada na blockchain.

## Detalhes do Token

- **Nome do Token**: MIDToken
- **Símbolo do Token**: MID
- **Decimals**: 18
- **Suprimento Total**: 500

#

- **Rede**: Sepolia Testnet
- **Contrato**: `0x9260cf462cc6136576e17660e83a156ccdd97c57`
- **Minha Wallet**: `0xCB85d8493d14Eab56e39e7D1406C3CffecE20a58`

#

### Etherscan
![Etherscan](https://github.com/user-attachments/assets/bf1749d4-230c-4877-bf1d-294958b140ee)

### Metamask
![Carteira de Metamask](https://github.com/user-attachments/assets/870b3f3d-783f-498a-9d2d-7b5a4dc419b9)

