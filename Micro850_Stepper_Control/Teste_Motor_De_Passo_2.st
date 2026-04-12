(* ========================================================================= *)
(* NOME DO ARQUIVO: TESTE MOTOR DE PASSO_2                                   *)
(* GERADOR DE PULSOS MANUAL PARA CLPs A RELÉ (SEM SUPORTE A PTO/MOTION)      *)
(* ========================================================================= *)
(* NOVIDADE 2.0: Tempo aumentado para T#250ms para garantir atracamento      *)
(* mecânico perfeito do solenóide do relé do Micro850.                       *)
(* ========================================================================= *)

(* Mapeamentos de Hardware que o Controlador já conhece:
   Entrada 00 = Sua Chave Seletora
   Saída 00   = Fio que vai pro PUL- (Pulsador)
   Saída 03   = Fio que vai pro DIR- (Direção Fixa)
*)

(* Lembrete: Declarar as "Variáveis Locais" do tipo "TON":
   - T_PULSO_ALTO
   - T_PULSO_BAIXO
*)

(* ----------------------------------------------------------- *)
(* 1. SENTIDO LÓGICO DA DIREÇÃO DO MOTOR *)
(* ----------------------------------------------------------- *)
_IO_EM_DO_03 := FALSE; (* FALSE = Gira num sentido / TRUE = Gira no sentido oposto *)


(* ----------------------------------------------------------- *)
(* 2. O CIRCUITO OSCILADOR LENTO PARA DAR TEMPO PRO RELÉ BATER *)
(* ----------------------------------------------------------- *)
(* Liga e desliga a cada 250ms (Tempo bom pro estalo do relé ser confiável) *)
T_PULSO_ALTO(
    IN := (_IO_EM_DI_00) AND (NOT T_PULSO_BAIXO.Q), 
    PT := T#250ms
);

T_PULSO_BAIXO(
    IN := T_PULSO_ALTO.Q,
    PT := T#250ms
);


(* ----------------------------------------------------------- *)
(* 3. ATIRANDO O PULSO DE VERDADE LÁ NO PLÁSTICO DA PORTA "OUT 0" *)
(* ----------------------------------------------------------- *)
IF (_IO_EM_DI_00 = TRUE) THEN
    _IO_EM_DO_00 := T_PULSO_ALTO.Q;
ELSE
    _IO_EM_DO_00 := FALSE;
END_IF;
