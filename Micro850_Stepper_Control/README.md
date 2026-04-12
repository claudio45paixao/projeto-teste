# Micro850 Stepper Motor Control (Relay Workaround)

Este repositório documenta a solução completa para o controle de um Drive de Motor de Passo (como o YS-DIV268N, TB6600, DM542) utilizando um CLP Allen-Bradley **Micro850 com Saídas a Relé (Modelo 2080-L50E-24QWB)**.

> [!WARNING]
> O modelo **-24QWB** possui saídas mecânicas a Relé. Blocos de movimento padrão do Connected Components Workbench (PTO - `MC_Power`, `MC_MoveVelocity`) são bloqueados por hardware neste modelo por segurança. Se deseja criar máquinas industriais de alta precisão, adquira os modelos com saída a Transistor **(-24QVB / -24QBB)** ou o módulo de expansão PTO **(2080-MOT-HSC)**. 

---

## 💡 A Solução Híbrida (Oscilador em Software)
Foi criada uma "Gambiarra de Engenharia" (oscilador de frequência super baixa por timers em linguagem ST - *Structured Text*) para forçar os relés mecânicos do CLP a atuarem como geradores de pulsos.

* **Frequência Operacional:** 250ms On / 250ms Off (Tolerante ao atracamento da mola mecânica).
* **Impacto:** Permite rotacionar o motor devagar para validações e demonstrações utilizando o hardware a relé pré-existente na bancada, contornando a proteção comercial.

## 📁 Arquivos do Projeto

- `Teste_Motor_De_Passo_2.txt`: Código estruturado ST otimizado (250ms) sem fiação da porta de Enable. 
- `Logica_Pulsos_Via_Rele_GAMBIARRA.txt`: Rotina histórica inicial onde ocorreu o debug da entrada não mapeada e do pino de inversão de estado.
- `Logica_PTO_Stepper_Motor.txt`: Código inicial nativo para eixos PTO via Blocos Motion, pronto para ser reaproveitado ao adquirir as CPUs à transistor da família QVB.

### Documentos de Hardware Associados
- `Checklist_Cabeamento_Fisico.txt`: Roteiro cru garantindo aterramentos CM0 nos Micro850.
- `Solucoes_Erro_Hardware_QVB_QWB.txt`: Explicação técnica oficial detalhando a incompatibilidade dos blocos e os guias de migração.

---

## ⚡ Esquema de Cabeamento ("Comum Anodo / Driver NPN")

| Driver `YS-DIV268N` | Destino | Função e Requisitos |
| :--- | :--- | :--- |
| **`DC+` e `DC-`** | Fonte de Corrente Contínua | Motor Power (Ex: 24V ou 48V) |
| **`A+`, `A-`, `B+`, `B-`** | Bobinas do Motor | *A+* (Amarelo), *A-* (Roxo), *B+* (Vermelho), *B-* (Verde) |
| **`EN+` e `EN-`** | ❌ VAZIOS | Pinos de "Disable". Se energizados, o motor fica frouxo. |
| **`PUL+`** e **`DIR+`** | VCC **(+5V)** | É Obrigatório isolar com Resistor 2K caso use fonte 24V! |
| **`PUL-`** | CLP **`OUT 00`** | O pulso bate e o motor caminha no degrau mecânico. |
| **`DIR-`** | CLP **`OUT 03`** | Controle de CW e CCW (Horário e Anti-Horário). |

*Lembrete do CLP:* A porta **`CM0`** no bloco de saídas precisou receber **GND (0V)** da mesma fonte lógica de +5V/+24V de pulso para o CLP poder direcionar este valor negativo às portas de relé e fechar a óptica do drive.
