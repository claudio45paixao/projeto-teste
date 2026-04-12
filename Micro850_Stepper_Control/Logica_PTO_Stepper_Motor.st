(* ====================================================================
NOME DO PROJETO: Controle de Motor de Passo (Micro850)
LINGUAGEM: ST (Texto Estruturado - Copie e cole dentro do CCW)
==================================================================== *)

(* 1. DECLARAÇÃO TÉCNICA E CÁLCULO DE VELOCIDADE (RPM -> Hz) *)
(* Se o seu drive (TB6600, DM542, etc) usa 200 passos/volta, mantenha em 200.0 *)
Motor_PPR := 200.0;
RPM_Desejado := 500.0;

(* O Bloco de Motion exige Hz (Pulsos por segundo), logo a regra é: *)
Velocidade_Final_Hz := (RPM_Desejado / 60.0) * Motor_PPR;

(* ================================================================= *)
(* 2. HABILITAR MOTOR DE PASSO (SERVO ON / DRIVER ENABLE)           *)
(* ================================================================= *)
(* O Bloco MC_Power injeta sinal no pino ENABLE do driver.           *)
(* A condição pra ele ligar é a "Chave_Seletora" física fechada.     *)
Inst_MC_Power(Eixo_Passo_1, Chave_Seletora, TRUE, TRUE);

(* ================================================================= *)
(* 3. DISPARADOR DE ROTAÇÃO CONTÍNUA (PTO)                          *)
(* ================================================================= *)
(* Observa se o MC_Power travou o freio/status com sucesso antes de rodar *)
(* Eixo, Execute, Velocity, Acceleration, Deceleration, Jerk, Direction, BufferMode *)
Inst_MC_MoveVelocity(Eixo_Passo_1, Inst_MC_Power.Status, Velocidade_Final_Hz, 800.0, 800.0, 0.0, 1, 0);

(* ================================================================= *)
(* 4. PARADA CONTROLADA (FREIO DE MÁQUINA)                          *)
(* ================================================================= *)
Inst_MC_Halt(Eixo_Passo_1, NOT Chave_Seletora, 1200.0, 0.0, 0);
