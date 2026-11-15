# RotaCerta - Flutter

Aplicativo de gerenciamento de pedidos desenvolvido em Flutter e Dart, com integração a uma API REST em Laravel.

## Sobre o projeto

O RotaCerta tem como objetivo facilitar o controle e a organização de pedidos, permitindo acompanhar suas informações e o andamento das entregas.

Este projeto foi desenvolvido como atividade acadêmica, utilizando arquitetura em camadas.

## Tecnologias utilizadas

- Flutter e Dart
- Laravel (API REST)
- SQLite
- HTTP
- GoRouter

## Funcionalidades previstas

- Login de usuário
- Listagem de pedidos
- Cadastro de pedidos
- Edição e exclusão de pedidos
- Alteração do status dos pedidos
- Visualização de pedidos pendentes e entregues

## Estrutura do projeto

O aplicativo está organizado em camadas:

- `models/` - Representação dos dados.
- `services/` - Comunicação com a API.
- `screens/` - Telas do aplicativo.
- `widgets/` - Componentes reutilizáveis.
- `core/` - Configurações de rotas, tema, constantes e validações.

## Telas e rotas

| Tela | Rota |
|---|---|
| Login | `/` |
| Início | `/inicio` |
| Pedidos | `/pedidos` |
| Novo pedido | `/pedidos/novo` |

## Como executar

É necessário ter o Flutter instalado e a API Laravel em execução.

Instale as dependências:

```bash
flutter pub get
```

Execute o aplicativo:

```bash
flutter run
```

## Repositório da API

https://github.com/GabrielVioli/RotaCerta-API

## Desenvolvimento

O projeto está em desenvolvimento. A estrutura inicial, as telas e a navegação foram criadas. A integração com a API e as operações de cadastro, edição e exclusão serão implementadas nas próximas etapas.

## Autor

Gabriel Vinicius de Oliveira

**Atividade acadêmica — Flutter/Dart**

**Back-end escolhido:** Opção A — API Laravel.