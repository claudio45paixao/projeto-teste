# Integração IHM PanelView 800 e CLP Micro850

Este diretório mantém a documentação referente à integração e controle entre a Interface Homem-Máquina (IHM - PanelView 800) e o Controlador Lógico Programável (CLP - Micro850).

## O Que Fizemos Até Agora

O foco principal tem sido estabelecer e documentar a **comunicação física Serial RS-485** entre os dois equipamentos para viabilizar o acionamento e controle remoto do motor de passo. 

As etapas de infraestrutura já definidas e documentadas foram:

1. **Pinagem da Porta Serial do CLP (Micro850):** 
   - Mapeamos a porta Mini-DIN do Micro850.
   - Identificamos os pinos cruciais para a comunicação RS-485:
     - **Pino 1:** Deve ser ligado o fio Laranja.
     - **Pino 8:** Deve ser ligado o fio Vermelho.
   - *Nota:* Foi gerado um diagrama visual (`Diagrama_Pinos_Micro850.html`) para auxiliar a evitar erros de ligação física nessa porta.

2. **Configuração Física na IHM (PanelView 800):**
   - Identificamos a necessidade de utilizar jumpers no bloco de terminais (borne) traseiro da IHM PanelView.
   - Essa configuração física em jumper é obrigatória para habilitar a rede de comunicação no formato RS-485 *half-duplex* (a 2 fios), fechando o barramento adequadamente e permitindo a comunicação com o CLP.

## Onde Estamos (Status Atual)

Atualmente a teoria física está mapeada. Estamos exatamente no **ponto de transição entre o cabeamento (Hardware) e o Software**. O próximo passo passa a envolver validações no Connected Components Workbench (CCW).

## Próximos Passos (To-Do)

- [ ] Confirmar o fim da crimpagem e da aparafusação dos fios nos bornes indicados (tanto Pinos 1 e 8 no CLP, quanto no conector em bloco da IHM com os devidos jumpers).
- [ ] Entrar no Connected Components Workbench (CCW) e na interface principal da IHM para configurar os *parâmetros lógicos da porta serial*:
  - *Baud Rate* (Taxa de velocidade)
  - *Paridade*
  - *Identificação do Nó (Node)* da rede (Protocolo Modbus RTU/CIP).
- [ ] Testar pulso da IHM para acionar a lógica de giro desenvolvida no CLP.
