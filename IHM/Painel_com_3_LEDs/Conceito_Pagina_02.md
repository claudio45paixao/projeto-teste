# Desenho da Página 02 (Painel Frontal)

Conforme alinhamos, esta pasta guarda o conceito para você desenhar a sua **Página 02**, que representará fisicamente o que o operador vê do lado de fora do quadro, de forma organizada.

## O Que Inserir na Página 02 (Desenho Físico e Layout)

Aqui você deve representar o layout da porta do painel (front end):

### 1. Manopla da Seccionadora Geral
- Desenhe a manopla (chave rotativa) da proteção geral.
- **TAG:** `QS-1`
- **Texto:** `DESLIGA GERAL / MAIN SWITCH`

### 2. Sinaleira de Painel Energizado (O LED Único)
Como vamos utilizar um Relé de Segurança/Falta de Fase por trás da porta, precisamos de apenas um LED:

- **Sinaleira Branca:**
  - **Símbolo:** Círculo com um "X" dentro
  - **TAG:** `H-1` (ou `H-T3`)
  - **Texto:** `PAINEL ENERGIZADO / MAIN POWER ON`
  - *Link Lógico (Entrada):* "Vem do contato 14 do Relé Falta de Fase (Pág 03)"
  - *Link Lógico (Saída/Fundo):* "Vai para a barra de N (Pág 03)"

---

### Links de Cross-Reference para a Página 03 (Como ligar)
A mágica vai acontecer lá na Página 3.
Na Página 02 ficará apenas a "casca" (a lâmpada visual) e na **Página 03 (Potência)** você desenha o controle elétrico para ela funcionar com segurança:

1. Desenhe um bloco quadrado representando o **Relé Falta de Fase** (Tag de exemplo: `RFF-1` ou `RPF-1`).
2. Puxe três cabinhos das fases principais R, S e T ligando nos três bornes do relé (geralmente L1, L2, L3).
3. Desenhe um **contato aberto (NA)** que pertence a esse relé (terminais 11 e 14).
4. Ligue a fase na entrada (11), a saída (14) você manda lá para a lâmpada Branca `H-1` da Página 02, e fecha a lâmpada no Neutro!

## Próximo Passo
Limpe as duas lâmpadas sobrando da Página 02, insira o Roteamento do Relé Falta de Fase na Página 03 e me mande o print para validar essa obra de arte!
