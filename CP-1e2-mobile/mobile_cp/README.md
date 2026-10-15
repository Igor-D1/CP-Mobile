# 🍽️ Restaurante Mesa Cheia

<p align="center">
  <b>Aplicativo mobile desenvolvido em Flutter para controle de lotação, gerenciamento de capacidade e fluxo de atendimento de clientes em tempo real.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Platform-Mobile%20%7C%20Web-blue?style=for-the-badge" alt="Platform" />
  <img src="https://img.shields.io/badge/Status-Concluído-success?style=for-the-badge" alt="Status" />
</p>

---

## 📱 Sobre o Projeto

O **Restaurante Mesa Cheia** é uma solução mobile desenvolvida com o objetivo de otimizar o controle de fluxo de pessoas em estabelecimentos gastronômicos. A aplicação monitora a lotação máxima permitida em tempo real, automatiza o cadastro de entradas e oferece ferramentas ágeis de gestão por meio de gestos e diálogos de confirmação interativos.

---

## ✨ Funcionalidades Principais

* **🎛️ Indicador de Capacidade em Tempo Real:** Barra de progresso dinâmica (com indicador visual de cores) que alerta quando o ambiente atinge níveis críticos ou lotação máxima ($50$ pessoas).
* **📝 Cadastro de Clientes:** Registro rápido de nome e identificação/matrícula com validação de campos obrigatórios e prevenção de duplicidade.
* **🚪 Gestão de Saídas:** Registro individual de saída de clientes, liberando vagas instantaneamente no contador geral do ambiente.
* **🗑️ Exclusão Individual e Geral:** 
  * Exclusão unitária de registros utilizando comandos deslizantes (`Slidable`) protegidos por alertas de confirmação (`AlertDialog`).
  * Botão condicional de **"Limpar Tudo"** (visível automaticamente quando a lista ultrapassa 5 registros), facilitando a redefinição de dados com segurança.
* **💬 Dicas de Usabilidade (Tooltips):** Suporte a dicas flutuantes explicativas em campos de formulário e botões de ação para auxiliar na experiência do usuário.
* **🔔 Feedback Visual Instantâneo:** Uso de `SnackBar` customizados para notificar o sucesso ou erros nas operações.

---

## 🎥 Vídeo de Demonstração

Assista à demonstração em vídeo do funcionamento do aplicativo:

👉 **https://youtu.be/kNMGjhVeBaw**

---

## 👥 Integrantes

* **Igor Dantas** — RM: 568337 — Turma: 2TDSPA
* **Guilherme Sena** — RM: 568101 — Turma: 2TDSPA

---

## 🛠️ Tecnologias Utilizadas

Este projeto foi construído utilizando as melhores práticas do ecossistema Flutter:

* **[Flutter](https://flutter.dev/)** - Framework de multiplataforma.
* **[Dart](https://dart.dev/)** - Linguagem de programação orientada a objetos.
* **Google Fonts (`google_fonts`)** - Tipografia personalizada (`Lato`).
* **Flutter Slidable** - Ações rápidas deslizantes nos itens da lista.

---

## 📐 Arquitetura e Organização do Código

O projeto segue uma estrutura limpa e modularizada para facilitar a manutenção e escalabilidade:

```text
lib/
│
├── models/
│   └── clientes.dart        # Modelo de dados da Pessoa (estado, horários, regras)
│
├── widgets/
│   └── pessoa_item.dart     # Componente visual customizado para os itens da lista
│
└── main.dart / pages/
    └── home_page.dart       # Tela principal com toda a lógica de estado e interface