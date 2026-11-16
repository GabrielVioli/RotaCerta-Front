# RotaCerta — Gestão de Pedidos

Aplicativo desenvolvido em **Flutter e Dart**, integrado a uma **API REST em Laravel**, com o objetivo de facilitar o gerenciamento de pedidos e o controle de itens em estoque.

## Sobre o projeto

O RotaCerta é um sistema acadêmico de gestão de pedidos que permite cadastrar itens, controlar suas quantidades disponíveis e acompanhar pedidos de clientes.

O projeto foi desenvolvido utilizando uma **arquitetura em camadas**, separando as responsabilidades da interface, navegação, validação, representação de dados e comunicação com o backend.

## Tecnologias utilizadas

- Flutter e Dart
- Laravel (API REST)
- SQLite
- HTTP
- GoRouter
- JSON

**Backend escolhido:** Opção A — API Laravel.

## Funcionalidades

- Login de usuário com autenticação por token.
- Tela inicial com acesso às funcionalidades.
- Cadastro, listagem, edição e exclusão de itens.
- Cadastro, listagem, edição e exclusão de pedidos.
- Alteração do status dos pedidos.
- Consulta de dados provenientes da API Laravel.
- Validação de formulários.
- Tratamento de carregamento, erros e listas vazias.

## Arquitetura

O aplicativo utiliza uma arquitetura em camadas, organizada dentro de `lib/`:

```text
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   ├── routes/
│   ├── theme/
│   └── utils/
├── models/
├── services/
├── screens/
└── widgets/
```

### Responsabilidades

- **Core:** configurações compartilhadas, rotas, tema e validações.
- **Models:** representação dos dados e conversão JSON.
- **Services:** comunicação HTTP com a API.
- **Screens:** telas e interação com o usuário.
- **Widgets:** componentes visuais reutilizáveis.

## Telas e rotas

| Tela | Rota |
|---|---|
| Login | `/` |
| Início | `/inicio` |
| Listagem de pedidos | `/pedidos` |
| Novo pedido | `/pedidos/novo` |
| Editar pedido | `/pedidos/:id/editar` |
| Estoque de itens | `/itens` |
| Novo item | `/itens/novo` |
| Editar item | `/itens/:id/editar` |

A navegação é gerenciada pelo pacote `go_router`, utilizando rotas nomeadas.

## Comunicação com a API

O Flutter consome os endpoints disponibilizados pelo backend Laravel por meio de requisições HTTP.

As operações são centralizadas no `ApiService`, enquanto os Models são responsáveis pela conversão dos dados JSON em objetos Dart.

O aplicativo utiliza `async/await` e `FutureBuilder` para trabalhar com operações assíncronas e apresentar os dados na interface.

## Como executar

É necessário ter o Flutter instalado e a API Laravel em execução.

**1. Instalar as dependências**

```bash
flutter pub get
```

**2. Iniciar o backend Laravel**

No diretório da API:

```bash
php artisan serve
```

**3. Executar o aplicativo Flutter**

```bash
flutter run -d chrome
```

A API deve estar acessível em `http://127.0.0.1:8000/api`, conforme a configuração do `ApiService`.

## Repositórios

**Frontend:**  
https://github.com/GabrielVioli/RotaCerta-Front

**Backend:**  
https://github.com/GabrielVioli/RotaCerta-API

## Autor

Gabriel Vinicius de Oliveira

Análise e Desenvolvimento de Sistemas — 4º período

Projeto acadêmico desenvolvido para integração entre Flutter e Laravel.