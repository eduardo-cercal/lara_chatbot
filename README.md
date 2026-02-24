# 🤖 Lara Chatbot

Lara é um chatbot inteligente e bem-humorado desenvolvido em Flutter. Ela utiliza o modelo **Gemini 1.5 Flash** via Firebase para oferecer conversas concisas, amigáveis e repletas de piadas.

## 🚀 Como rodar o projeto do zero

### Pré-requisitos

* Flutter SDK (Versão 3.29.0 ou superior recomendada)
* Dart SDK
* Um projeto configurado no [Firebase Console](https://console.firebase.google.com/)

### Passo a Passo

1. **Clone o repositório:**
```bash
git clone https://github.com/eduardo-cercal/lara_chatbot.git
cd lara_chatbot

```


2. **Instale as dependências:**
```bash
flutter pub get

```


3. **Configuração do Firebase:**
* Crie um projeto no Firebase.
* Adicione um app Android ao projeto.
* Baixe o arquivo `google-services.json` e coloque-o em `android/app/`.
* Ative o **Google Auth** e o **Vertex AI (Firebase AI)** no console do Firebase.


4. **Execute o projeto:**
```bash
flutter run

```



---

## 🔑 Configurando o Login com Google

O erro comum `[16] Account reauth failed` é evitado seguindo estes passos:

1. **Gerar SHA-1:**
No terminal, dentro da pasta `android`:
```bash
./gradlew signingReport

```


2. **Cadastrar no Firebase:**
Copie a SHA-1 da variante `debug` e cole nas configurações do app Android no Firebase Console.
3. **Tela de Consentimento:**
No [Google Cloud Console](https://console.cloud.google.com/), configure a tela de consentimento OAuth como **Externo** e adicione seu e-mail como usuário de teste.
4. **Android Intent:** Verifique se o `google_sign_in` está configurado corretamente no seu arquivo `build.gradle`.

---

## 🧠 Configurando a IA (Gemini)

A Lara utiliza o `flutter_ai_toolkit` integrado ao Firebase.

1. **Ativar Vertex AI:** No Firebase Console, vá em "Build" > "Vertex AI" e clique em "Get Started".
2. **Instruções de Sistema:** A personalidade da Lara é definida através da `systemInstruction` no `FirebaseProvider`:
```dart
systemInstruction: Content.system(
  'Seu nome é Lara. Você é um chatbot amigável que adora contar piadas...'
)

```


3. **API Key:** Ao usar o `FirebaseProvider`, a autenticação é feita via Firebase Auth, eliminando a necessidade de expor chaves de API do Google AI no código cliente.

---

## 🧪 Cenários de Teste

Para garantir que tudo está funcionando, teste os seguintes fluxos:

* **Cenário 1: Login Social:** Clique no botão circular do Google. Verifique se o seletor de contas aparece e se você é redirecionado para o Dashboard.
* **Cenário 2: Persistência de Título:** Inicie um novo chat. Envie "Olá, qual o seu nome?". Verifique se o título da AppBar muda de "Nova conversa" para a sua pergunta com uma animação.
* **Cenário 3: Personalidade:** Pergunte "Conte-me uma piada". Verifique se a Lara responde em português com um tom humorístico.
* **Cenário 4: Histórico:** Saia de um chat, volte para o Dashboard e reabra a conversa. O histórico deve ser carregado e as mensagens devem aparecer nas cores corretas (Azul para usuário, Azul claro para Lara).

---

## 🛠 Decisões Técnicas

* **Gerenciamento de Estado (GetX):** Escolhido pela simplicidade na navegação, gerenciamento de dependências e reatividade (`Obx`).
* **Interface (Material 3 + Custom UI):** O app utiliza uma mistura de componentes nativos com estilização personalizada (Cards arredondados e sombras leves) para uma estética moderna.
* **LlmChatView:** Utilização do toolkit oficial para acelerar a implementação de streaming de mensagens e suporte a provedores de IA.
* **Clean Architecture (Simplificada):** Organização em pastas por `features` (login, dashboard, chat) para facilitar a escalabilidade.

---