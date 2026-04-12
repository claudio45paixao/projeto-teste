(* ========================================================================= *)
(* GERADOR DE PULSOS MANUAL PARA CLPs A RELÉ (SEM SUPORTE A PTO/MOTION)      *)
(* ========================================================================= *)
(* AVISO: CLPs a Relé não foram feitos para acionar motores de passo!        *)
(* O relé atuará muito rápido. Use períodos de acionamento de pelo menos     *)
(* 30ms (T#30ms) para cima. Velocidades máximas em torno de 5 a 10 RPM.      *)
(* ========================================================================= *)

(* Mapeados diretamente para as Saídas (DO) Originais:
   Pino 06 = Enable
   Pino 03 = Direção
   Pino 00 = Pulso

   Lembre-se apenas de declarar nas "Variáveis Locais":
   - T_PULSO_ALTO (Tipo: TON)
   - T_PULSO_BAIXO (Tipo: TON)
*)

(* 1. Habilita a Força/Holding do Drive do Motor de Passo diretamente na porta 06 *)
_IO_EM_DO_06 := _IO_EM_DI_00;

(* 2. Define o sentido lógico diretamente na porta 03 (Estático para testes) *)
_IO_EM_DO_03 := FALSE; (* FALSE = Horário / TRUE = Anti-Horário *)

(* 3. Lógica do Circuito Oscilador (Gerador de Pulsos ou "Clock") *)
T_PULSO_ALTO(
    IN := (_IO_EM_DI_00) AND (NOT T_PULSO_BAIXO.Q), 
    PT := T#30ms
);

T_PULSO_BAIXO(
    IN := T_PULSO_ALTO.Q,
    PT := T#30ms
);

(* 4. Transmissão do Pulso para a Saída Física do Relé 00 (o seu STEP) *)
IF (_IO_EM_DI_00 = TRUE) THEN
    _IO_EM_DO_00 := T_PULSO_ALTO.Q;
ELSE
    _IO_EM_DO_00 := FALSE;
END_IF;
