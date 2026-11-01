# Sistema bancário em COBOL
Sistema de operações de CONSULTA, DEPÓSITO e SAQUE de saldo de contas bancárias com COBOL.


## Considerações

COBOL não é uma linguagem que cria interfaces gráficas ou programas complexos e extensos, considerando o Desenvolvimento de Software atual.

Sua aplicação está nos bastidores de sistemas que necessitam de uma segurança rígida na gestão de dados numerosos com alta performance.

Ciente disso, o presente programa COBOL desenvolvido pautou-se em um cenário real: consumir e tratar os dados considerando que há algum outro sistema noutra camada de arquitetura, que irá gerar o arquivo de dados utilizado ou até mesmo consumi-lo depois de tratado.

---

## Sobre o Programa

**1. MENU INICIAL:**
- Entre com seu ID;

**2. MENU PÓS-LOGIN:**
- Consultar saldo;
- Depositar saldo;
- Sacar saldo;

"SB" é acrônimo de "Sistema Bancário".

Em ambiente de produção, o ID sequer seria solicitado ao usuário. Seria desenvolvida uma integração entre os sistemas: uma aplicação de outra camada acionaria o programa em COBOL, fornecendo o ID necessário.

De posse dessa informação, o programa seria executado automaticamente, gerando os relatórios que seriam posteriormente consumidos por outros sistemas, sem qualquer interação com o usuário.

Em outras palavras, o usuário sequer saberia da existência do COBOL — toda a comunicação e execução ocorreriam nos bastidores. Esse é o sentido de existência do COBOL.

---

## Autor
Willian Ferreira Gonçalves
