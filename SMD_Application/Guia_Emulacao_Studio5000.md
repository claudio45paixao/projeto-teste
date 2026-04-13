# Guia de Emulação — SMD_Application no Studio 5000

## Contexto

Este guia documenta os ajustes realizados no programa `SMD_Application.L5X` para rodar
no **RSLogix Emulate** (emulador virtual do CompactLogix 5380) sem hardware físico conectado.

---

## Correções Aplicadas no L5X

### 1. Atualização de Nomes de Instruções (Warnings → Resolvidos)

O Studio 5000 v38 renomeou instruções antigas. As seguintes substituições foram feitas na
routine `R10_Main_State_Machine`:

| Instrução Antiga | Instrução Nova | Motivo |
|-----------------|---------------|--------|
| `EQU`           | `EQ`          | Nome atualizado na versão 38 |
| `MOV`           | `MOVE`        | Nome atualizado na versão 38 |

Rungs afetados:
```
Rung 0: EQ(Machine_State,0) XIC(startOperation) XIC(readyToStart) MOVE(10,Machine_State)
Rung 1: EQ(Machine_State,10) XIC(applyLabelAxis_inp) MOVE(20,Machine_State) OTL(takeLabel)
```

---

### 2. Adaptação do R00_IO_Mapping para Emulação (5 Erros → Resolvidos)

O routine `R00_IO_Mapping` referenciava módulos de I/O físico que não existem no emulador.
Cada referência foi substituída por uma tag de simulação interna.

#### Entradas (I → Sim Tags)

| Rung | Endereço Físico Original | Tag de Simulação | Descrição |
|------|------------------------|-----------------|-----------|
| 0 | `Local:3:I.Pt00.Data` | `sim_s1_input` | Sensor do Carrinho Entrada S1 |
| 1 | `Local:4:I.Pt07.Data` | `sim_axis_busy` | Eixo Z em translação (BUSY) |
| 2 | `Local:4:I.Pt10.Data` | `sim_axis_inp` | Eixo Z IN-POSITION |

#### Saídas (O → NOP)

| Rung | Endereço Físico Original | Substituição | Descrição |
|------|------------------------|-------------|-----------|
| 3 | `Local:6:O.Pt13.Data` | `NOP()` | SVON — liga servo |
| 4 | `Local:6:O.Pt11.Data` | `NOP()` | DRIVE — dispara eixo Z |

---

## Tags de Simulação Criadas

Adicionadas ao programa `SMD_Application` (escopo local):

| Tag | Tipo | Valor Padrão | Como usar |
|-----|------|-------------|-----------|
| `sim_s1_input` | BOOL | 0 | Sete 1 para simular sensor S1 ativo |
| `sim_axis_busy` | BOOL | 0 | Sete 1 para simular eixo em movimento |
| `sim_axis_inp` | BOOL | 0 | Sete 1 para simular IN-POSITION (eixo chegou ao alvo) |

---

## Passo a Passo: Subir o Projeto no Emulador

### Pré-requisitos
- Studio 5000 Logix Designer v38 instalado
- RSLogix Emulate instalado e rodando
- Arquivo `SMD_Application.L5X` atualizado (este repositório)

### Procedimento

1. **Abrir o projeto** no Studio 5000
2. **Importar o programa**: botão direito em `MainTask` → `Import Program` → selecionar `SMD_Application.L5X`
3. **Verificar path**: barra superior deve mostrar `EmulateEthernet\127.0.0.1`
4. **Ir Online**: `Communications → Go Online` (Ctrl+W)
5. **Download**: quando solicitado, clicar em `Download → Yes`
6. **Colocar em Run**: clicar em `Rem Prog` → selecionar `Rem Run` → confirmar `Yes`

---

## Como Simular Todas as Variáveis

Acesse as tags em: `SMD_Application → Parameters and Local Tags`

### Cadeia de habilitação (deve ser feita na ordem)

```
sim_s1_input = 1
    └── inputArea_s1 = 1  (via R00_IO_Mapping, Rung 0)
        └── readyToStart = 1  (via R01_Desktop_Interface, Rung 0, se doorOpened=0)
```

### Tabela completa de simulação — Máquina de Estados

| Passo | Tag para setar | Valor | Resultado esperado |
|-------|---------------|-------|-------------------|
| 1 | `sim_s1_input` | 1 | `readyToStart` vai para 1 |
| 2 | `startOperation` | 1 | `Machine_State`: 0 → **10** |
| 3 | `sim_axis_inp` | 1 | `Machine_State`: 10 → **20**, `takeLabel` = 1 |

### Tabela completa de todas as tags do programa

| Tag | Tipo | Escopo | Descrição |
|-----|------|--------|-----------|
| `startOperation` | BOOL | Local | Botão Start virtual do Desktop (Bit 1) |
| `readyToStart` | BOOL | Local | Máquina sem alarmes, cartões OK, portas fechadas (Bit 0) |
| `takeLabel` | BOOL | Local | Comando pegar etiqueta — HMI ou máquina de estados (Bit 2) |
| `labelCollected` | BOOL | Local | Flag: Gripper puxou tag e vácuo confirmou (Bit 3) |
| `applyLabel` | BOOL | Local | Disparo processo de aplicação — desce eixo Z (Bit 4) |
| `labelApplied` | BOOL | Local | Conclusão da descida Z e alívio vácuo (Bit 5) |
| `discardReelToRejectArea` | BOOL | Local | Reel com falha → rejeitar no elevador (Bit 6) |
| `doorOpened` | BOOL | Local | Porta aberta — bloqueia servos (NR12) |
| `inputArea_s1` | BOOL | Local | Sensor Carrinho Entrada S1 (derivado de sim_s1_input) |
| `labelApplication_X` | DINT | Local | Offset X da visão (décimos de mm) — Reg 0 |
| `labelApplication_Y` | DINT | Local | Offset Y da visão (décimos de mm) — Reg 1 |
| `labelApplication_Angle` | DINT | Local | Rotação Teta do Gripper — Reg 2 |
| `reelPosition` | DINT | Local | Index do Rolo ativo (1 a 5) — Reg 3 |
| `liftInputTargetPosition_pulses` | DINT | Local | Target Position Modbus Elevador (ID=3) — Reg 3202/3203 |
| `liftInputGoToPosition` | BOOL | Local | Trigger de posicionamento Modbus |
| `applyLabelAxis_svon` | BOOL | Local | Saída: Liga servo (pino A13) |
| `applyLabelAxis_drive` | BOOL | Local | Saída: Dispara eixo Z (pino A11) |
| `applyLabelAxis_setup` | BOOL | Local | Saída: Comando Origin (pino A9) |
| `applyLabelAxis_busy` | BOOL | Local | Entrada: Eixo em translação (pino B7) |
| `applyLabelAxis_svre` | BOOL | Local | Entrada: Servo Ready confirmado (pino B11) |
| `applyLabelAxis_inp` | BOOL | Local | Entrada: IN-POSITION — eixo no alvo (pino B10) |
| `applyLabelAxis_alarm` | BOOL | Local | Entrada: Alarme do servo (pino B13) |
| `Machine_State` | DINT | Local | Registrador Sequenciador Grafcet |
| `sim_s1_input` | BOOL | Local | **[EMULACAO]** Simula Local:3:I.Pt00.Data |
| `sim_axis_busy` | BOOL | Local | **[EMULACAO]** Simula Local:4:I.Pt07.Data |
| `sim_axis_inp` | BOOL | Local | **[EMULACAO]** Simula Local:4:I.Pt10.Data |

---

## Estados da Máquina de Estados (Machine_State)

| Valor | Significado |
|-------|-------------|
| 0 | Idle — aguardando `startOperation` e `readyToStart` |
| 10 | Operação iniciada — aguardando eixo Z chegar à posição |
| 20 | Eixo Z IN-POSITION — `takeLabel` acionado |

> Novos estados serão adicionados conforme o projeto evolui.

---

## Observações para Retorno ao Hardware Real

Quando conectar ao CLP físico (5069-L310ER), reverter em `R00_IO_Mapping`:

| Rung | Remover (emulação) | Restaurar (hardware) |
|------|-------------------|---------------------|
| 0 | `XIC(sim_s1_input)` | `XIC(Local:3:I.Pt00.Data)` |
| 1 | `XIC(sim_axis_busy)` | `XIC(Local:4:I.Pt07.Data)` |
| 2 | `XIC(sim_axis_inp)` | `XIC(Local:4:I.Pt10.Data)` |
| 3 | `NOP()` | `XIC(applyLabelAxis_svon)OTE(Local:6:O.Pt13.Data)` |
| 4 | `NOP()` | `XIC(applyLabelAxis_drive)OTE(Local:6:O.Pt11.Data)` |
