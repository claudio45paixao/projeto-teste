# Relatório de Correções — Diagrama Elétrico SMD INSPECTION
**Projeto:** SMD INSPECTION — FOXCONN DO BRASIL  
**Arquivo DWG:** DIAGRAMA ELETÍCO FOXCONN.dwg  
**Revisão do check:** 01  
**Data:** 2026-04-13  
**Responsável check:** Claude / Francisco Claudio  

---

## INSTRUÇÕES DE USO
Abra o arquivo `DIAGRAMA ELETÍCO FOXCONN.dwg` no AutoCAD e aplique cada correção
na folha indicada. Após aplicar, marque o item com [x].

---

## FOLHA 01 — CAPA / SUMÁRIO (Pág. 01)

Nenhuma correção necessária nesta folha.

---

## FOLHA 02–03 — SUMÁRIO (Pág. 01 e 02)

### [C-E1] Falta entrada no índice
- **Problema:** O sumário pula da entrada "07 – SERVO DRIVE – ELEVADOR DE ENTRADA"
  diretamente para "09 – SERVO DRIVE – ELEVADOR DE SAÍDA". A página 08 está ausente.
- **Correção:** Inserir entre as entradas 07 e 09:
  ```
  08 – SERVO DRIVE – ELEVADOR DE REJEITO
  Acionamento servo do elevador de rejeito de bandejas com falha.
  ```
- **Folha DWG:** Folha de sumário (PAG 02/03)

---

## FOLHA PAG. 03 — DIAGRAMA DE FORÇA 1

### [C-E3] Cross-reference da Fonte 24V incorreto
- **Problema:** A Pág. 05 (Fonte 24V) referencia "DE PÁG. 04 TERM. QF1", mas
  a Pág. 04 (Diagrama de Força 2) começa em QF2. QF1 está na pág. 05 em si.
- **Correção:** Alterar o texto na Pág. 05 de:
  ```
  DE PÁG. 04 TERM. QF1
  ```
  Para:
  ```
  DE PÁG. 03 BARRAMENTO R — TERM. QF1
  ```
- **Folha DWG:** PAG 03 (Diagrama de Força 1) e PAG 05 (Fonte 24V)

---

## FOLHA PAG. 04 — DIAGRAMA DE FORÇA 2 (Barramento)

### [C-T1] Disjuntores sem corrente nominal
- **Problema:** Os 9 disjuntores DSJ Monopolar (QF2 a QF10) não têm o valor
  de corrente indicado no diagrama.
- **Correção:** Adicionar o valor em Amperes ao lado de cada designador conforme tabela:

| Designador | Carga | Corrente sugerida |
|-----------|-------|-----------------|
| QF2 | FONTE 220VAC | 10A |
| QF3 | CLP | 6A |
| QF4 | ROBO EPSON | 16A |
| QF5 | IMPRESSORA | 10A |
| QF6 | CPU | 10A |
| QF7 | RAIO X | 16A |
| QF8 | DRIVE 1 | 16A |
| QF9 | DRIVE 2 | 16A |
| QF10 | DRIVE 3 | 16A |

> **Nota:** Confirmar valores reais com datasheet de cada equipamento antes de aplicar.

---

## FOLHA PAG. 06 — ENTRADAS DIGITAIS CLP / CONTROLE (Módulo 1)

### [C-C2a] Conflito de nomes DI_001 e DI_002
- **Problema:** DI_001 e DI_002 são usados nesta folha para START/STOP de máquina,
  mas também são usados na folha PAG 17 para Emergência Canal A/B.
- **Correção:** Renomear as entradas desta folha:
  - `DI_001 START MAQUINA/BOT NA` → `DI_001 START MAQUINA/BOT NA` *(manter)*
  - `DI_002 STOP MAQUINA BOT NF` → `DI_002 STOP MAQUINA BOT NF` *(manter)*
  - Na folha PAG 17 (Segurança), renomear para `DIS_001` e `DIS_002` (prefixo S = Safety)

---

## FOLHA PAG. 07 — ENTRADAS DIGITAIS CLP / CONTROLE (Módulo 2 e 3)

### [C-C3] B1S1 (X10) não mapeado
- **Problema:** O sensor B1S1 (X10) existe na folha de sensores (PAG 15)
  mas não aparece mapeado no módulo de entradas. O mapeamento começa em
  DI_022 = B1S2 (X11), pulando B1S1.
- **Correção:** Alterar DI_021 de indefinido para:
  ```
  DI_021  B1S1 (X10)   ← Sensor 1 do Elevador de Entrada
  ```

### [C-C4] DI_021 sem label
- **Problema:** DI_021 está no diagrama sem nenhuma descrição de sinal.
- **Correção:** Aplicar a correção C3 acima — definir como `B1S1 (X10)`.

### [C-C5] DI_030 com interrogação
- **Problema:** DI_030 está rotulado como `DI_030 ? B2S5 (X19)` — o "?" indica
  incerteza não resolvida.
- **Correção:** Confirmar se é realmente B2S5 do Elevador de Saída e remover o "?":
  ```
  DI_030  B2S5 (X19)   ← Sensor 5 do Elevador de Saída
  ```

### [C-T2a] Nomenclatura de drives inconsistente
- **Problema:** DI_015 a DI_020 usam "Drive X", "Drive Y", "Drive Z" mas o sistema
  tem 5 drives (3 elevadores + 2 cartesianos).
- **Correção:** Renomear conforme tabela:

| Atual | Correto |
|-------|---------|
| DI_015 Drive X Ready | DI_015 DR1-El.Entrada READY |
| DI_016 Drive Y Ready | DI_016 DR2-El.Saída READY |
| DI_017 Drive Z Ready | DI_017 DR3-El.Rejeito READY |
| DI_018 Drive X Fault | DI_018 DR1-El.Entrada FAULT |
| DI_019 Drive Y Fault | DI_019 DR2-El.Saída FAULT |
| DI_020 Drive Z Fault | DI_020 DR3-El.Rejeito FAULT |

> **Nota:** Drives do Cartesiano X e Y (DR4, DR5) — verificar se precisam de
> entradas READY/FAULT mapeadas e adicionar se necessário.

---

## FOLHA PAG. 08 — SAÍDAS DIGITAIS CLP M16

### [C-E4] DO_001 e DO_002 ausentes
- **Problema:** O módulo de saídas começa em DO_003, sem indicação de onde
  estão DO_001 e DO_002.
- **Correção (opção A):** Adicionar as saídas faltantes:
  ```
  DO_001  [definir sinal — ex: HABILITAÇÃO GERAL / PRONTO]
  DO_002  [definir sinal — ex: ALARME / FALHA GERAL]
  ```
- **Correção (opção B):** Se DO_001 e DO_002 estiverem em outro módulo,
  adicionar nota de cross-reference indicando a folha onde estão.

### [C-E6] Typo no label DO_006
- **Problema:** `D0_006 START RAIO-X` usa zero (0) em vez da letra O.
- **Correção:** Alterar `D0_006` para `DO_006`.

### [C-T2b] Nomenclatura de enables de drive
- **Problema:** DO_010/011/012 são "ENABLE DRIVE X/Y/Z" — inconsistente com
  os 5 drives do sistema.
- **Correção:** Renomear:
  ```
  DO_010  ENABLE DR4-CARTESIANO X
  DO_011  ENABLE DR5-CARTESIANO Y
  DO_012  [verificar se necessário ou usar para outro drive]
  ```

---

## FOLHA PAG. 09 — SAÍDAS DIGITAIS CLP M8 (Módulo Segurança)

### [C-C2b] Conflito DI_001 / DI_002 — Safety
- **Problema:** Esta folha usa `DI_001 EMERG. GERAL CANAL A` e
  `DI_002 EMERG. GERAL CANAL B`, mas esses nomes já estão usados na PAG 06.
- **Correção:** Renomear as entradas de segurança nesta folha e na PAG 17:
  ```
  DIS_001  EMERG. GERAL — CANAL A / BOT NF
  DIS_002  EMERG. GERAL — CANAL B / BOT NF
  DIS_003  PORTAS 1-6 CANAL A (SÉRIE)
  DIS_004  PORTAS 1-6 CANAL B (SÉRIE)
  ```

### [C-E2] Typo Allen Braddey → Allen Bradley
- **Problema:** Em todas as folhas com módulos CLP, o fabricante está escrito
  incorretamente como "Allen Braddey".
- **Correção:** Localizar e substituir em **todas as folhas**:
  ```
  Allen Braddey  →  Allen-Bradley
  ```

---

## FOLHAS PAG. 10, 11, 12, 13, 14 — SERVO DRIVES

### [C-C1] CRÍTICO — Todos os drives com mesmo designador "04Q-2"
- **Problema:** Os 5 diagramas de servo drive (PAG 10 a 14) mostram o mesmo
  disjuntor de proteção "04Q-2 16A", o que significa que todos estão no mesmo
  circuito sem proteção individual.
- **Correção:** Criar proteção individual para cada drive:

| Folha | Drive | Designador correto |
|-------|-------|------------------|
| PAG 10 | Servo Motor 1 — Elevador de Entrada | QF-DR1 — 10A |
| PAG 11 | Servo Motor 2 — Elevador de Saída | QF-DR2 — 10A |
| PAG 12 | Servo Motor 3 — Elevador de Rejeito | QF-DR3 — 10A |
| PAG 13 | Servo Motor 4 — Cartesiano X | QF-DR4 — 10A |
| PAG 14 | Servo Motor 5 — Cartesiano Y | QF-DR5 — 10A |

> **Nota técnica:** O drive INVT DA180-S4RSCG0 tem corrente de entrada de 6,8A.
> Um disjuntor de 10A oferece melhor proteção que 16A para este caso.
> Confirmar com o datasheet do drive antes de alterar.

### [C-T3] Disjuntor 16A para drive de 6,8A
- **Problema:** 16A para um drive de entrada 6,8A é superdimensionado.
- **Correção:** Avaliar redução para **10A** em cada QF individual dos drives.

### [C-T4] Referência -24V sem fonte geradora
- **Problema:** Os diagramas de drive mostram -24V no conector de IO, mas
  a fonte 24V (PAG 05) gera apenas P24V (+24V) e N0V (0V). Não há fonte bipolar.
- **Correção (opção A):** Se -24V é o referencial (0V), corrigir label para `0V` ou `N24V`.
- **Correção (opção B):** Se realmente necessita -24V, adicionar fonte bipolar
  ao projeto e documentar na PAG 05.

---

## FOLHA PAG. 15 — SENSORES DOS ELEVADORES

### [C-T4b] -24V nos sensores
- **Problema:** O barramento de retorno dos sensores está rotulado como -24V.
  Para sensores NPN/PNP padrão 3 fios, o retorno é 0V.
- **Correção:** Alterar label `-24V` para `0V (N24V)` no barramento de retorno.

---

## FOLHA PAG. 16 — SISTEMA DE SEGURANÇA — EMERGÊNCIA

### [C-T6] Botão E-STOP físico não representado
- **Problema:** O circuito referencia "Canal Emerg. A — Bot NF" mas não há
  símbolo de botão de emergência físico desenhado no diagrama.
- **Correção:** Adicionar símbolo do botão cogumelo de emergência (NF) no
  diagrama, antes da entrada no relé de segurança, com:
  - Designador: `S-EMERG`
  - Tipo: Botão cogumelo NF, auto-travante, conforme NR12

### [C-T5] K3 e K4 sem circuito completo
- **Problema:** K3 e K4 aparecem no canto inferior direito desta folha sem
  ter suas bobinas (A1/A2) claramente identificadas e conectadas.
- **Correção:** Completar o diagrama das bobinas de K3 e K4, mostrando:
  - Alimentação A1/A2 de cada contator
  - Sinal de controle (24V CLP ou saída de segurança)

---

## FOLHA PAG. 17 — SISTEMA DE SEGURANÇA — EMERGÊNCIA (Cont.)

### [C-C2c] DI_001/DI_002 Safety — renomear
- **Problema:** Mesma questão de conflito de nomes descrita anteriormente.
- **Correção:** Alterar nomes nesta folha para:
  ```
  I:00  →  DIS_001  EMERG.-CANAL A
  I:01  →  DIS_002  EMERG.-CANAL B
  I:02  →  DIS_003  PORTAS 1-3 CANAL A (SÉRIE)
  I:03  →  DIS_004  PORTAS 3-6 CANAL B (SÉRIE)
  I:04  →  DIS_005  FEEDBACK EDM
  ```

### [C-E5] Inconsistência número de portas
- **Problema:** PAG 16 diz "PORTAS 1-6 CANAL A (SÉRIE)", PAG 17 diz
  "PORTAS 1-3 CANAL A (SÉRIE)" e "PORTAS 3-6 CANAL B (SÉRIE)".
- **Correção:** Padronizar conforme número real de portas da máquina:
  - Se são 6 portas no total divididas em 2 grupos de 3:
    ```
    PAG 16: CANAL A — PORTAS 1-3 (SÉRIE) / CANAL B — PORTAS 4-6 (SÉRIE)
    PAG 17: PORTAS 1-3 CANAL A / PORTAS 4-6 CANAL B
    ```
  - Se são 6 portas todas em série no canal A:
    ```
    PAG 16 e 17: PORTAS 1-6 CANAL A (SÉRIE)
    ```

### [C-E2] Typo Allen Braddey → Allen-Bradley
- Mesma correção: substituir em todas as ocorrências desta folha.

---

## RESUMO DE CORREÇÕES POR FOLHA

| Folha DWG | Qtde correções | Prioridade |
|-----------|---------------|-----------|
| Sumário | 1 | Baixa |
| PAG 03 | 1 | Baixa |
| PAG 04 | 1 | Média |
| PAG 06 | 1 | Alta |
| PAG 07 | 4 | Alta |
| PAG 08 | 3 | Alta |
| PAG 09 | 2 | Alta |
| PAG 10 a 14 | 3 (cada) | **CRÍTICA** |
| PAG 15 | 1 | Média |
| PAG 16 | 2 | Alta |
| PAG 17 | 3 | Alta |
| **Global** | **Typo Allen Bradley** | Média |

---

## CHECKLIST DE APLICAÇÃO

- [ ] C-E1 — Sumário: inserir entrada 08 Elevador de Rejeito
- [ ] C-E2 — Global: corrigir "Allen Braddey" → "Allen-Bradley" em todas as folhas
- [ ] C-E3 — PAG 05: corrigir cross-reference QF1
- [ ] C-E4 — PAG 08: definir DO_001 e DO_002
- [ ] C-E5 — PAG 16/17: padronizar número de portas no circuito de segurança
- [ ] C-E6 — PAG 08: corrigir typo D0_006 → DO_006
- [ ] C-C1 — PAG 10–14: criar designadores individuais para cada drive (QF-DR1 a QF-DR5)
- [ ] C-C2 — PAG 09/17: renomear DI_001/DI_002 safety para DIS_001/DIS_002
- [ ] C-C3 — PAG 07: mapear B1S1 (X10) em DI_021
- [ ] C-C4 — PAG 07: DI_021 recebe label B1S1 (X10)
- [ ] C-C5 — PAG 07: remover "?" de DI_030 B2S5
- [ ] C-T1 — PAG 04: adicionar corrente nominal nos QF2–QF10
- [ ] C-T2 — PAG 07/08: padronizar nomenclatura de drives (DR1–DR5)
- [ ] C-T3 — PAG 10–14: avaliar redução para 10A nos disjuntores dos drives
- [ ] C-T4 — PAG 10–15: verificar e corrigir referência -24V
- [ ] C-T5 — PAG 16: completar circuito bobinas K3 e K4
- [ ] C-T6 — PAG 16: adicionar símbolo do botão E-STOP físico

---
*Gerado em 2026-04-13. Aplicar no DWG e gerar novo PDF após revisão.*
