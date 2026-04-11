# Automação de Aplicação SMD - Rockwell CompactLogix 5380

Este repositório contém a lógica LADDER (arquitetura Studio 5000 Logix Designer) para uma máquina automatizada de aplicação de etiquetas em componentes SMD. 
A arquitetura foi projetada com o desacoplamento de hardware, utilizando a interface Modbus RTU para eixos auxiliares e controle I/O direto para os eixos de aplicação.

## 📁 Estrutura do Projeto

* `SMD_Application.L5X`: O programa LADDER estruturado na linguagem XML da Rockwell. Pode ser importado diretamente como um **Program** no `MainTask` de projetos Studio 5000 (v38).
* `Tags_PLC_SMD_X.xlsx`: Planilha de Mapeamento de Memória original que define o handshake do sistema Desktop, controle do Elevador e Setup IOs do eixo Cartesiano/Garra.
* `Molde.L5X`: Backup de segurança de *Headers* do Studio 5000 para forçar compatibilidade.

## 🚀 Como Importar (Deploy)

1. Abra o seu projeto no **Studio 5000 Logix Designer**.
2. No menu da esquerda, clique com o **Botão Direito** sobre `MainProgram` (debaixo de Tasks -> MainTask).
3. Selecione `Add` e em seguida `Import Routine...` ou em níveis superiores (`Import Program...`).
4. Selecione o arquivo `SMD_Application.L5X` contido neste repositório.

## 🧠 Arquitetura de Rotinas
1. **R00_IO_Mapping:** Isola endereços físicos (Local:3:I) da lógica de negócios.
2. **R01_Desktop_Interface:** Permissivos e handshake entre Desktop (Supervisório/Visão) e CLP.
3. **R02_Elevators_ModbusRTU:** Processamento das requisições via portas Seriais (Instruções genéricas MSG).
4. **R03_Servos_Discretos:** Intertravamentos vitais das portas de driver de passo para a subida/descida do Motor Z e Gripper T.
5. **R10_Main_State_Machine:** Lógica transacional Grafcet executando os steps sequenciais de máquina (Start -> Descer Garra -> Puxar Vácuo -> ...).

---
*Gerado para versionamento Git.*
