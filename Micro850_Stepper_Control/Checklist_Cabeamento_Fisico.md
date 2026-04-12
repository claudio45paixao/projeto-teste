========================================================================
CHECKLIST DE LIGAÇÃO FÍSICA: MICRO850 (RELÉ) -> DRIVE DE MOTOR DE PASSO
========================================================================

Este guia de bancada garante que a lógica de "Oscilador via Relé" (Gambiarra) 
que desenhamos em ST feche o ciclo mecânico na prática, ligando fisicamente  
o CLP ao seu Driver do Motor (Ex: DM542, TB6600, etc).

[ ] PASSO 1: ALIMENTAÇÃO DO SISTEMA
    - Certifique-se de que o Micro850 e o Drive do Motor estão energizados.
    - O motor de passo de 4 fios (bipolar) deve estar com suas bobinas 
      (A+, A-, B+, B-) devidamente parafusadas diretamente no Drive.

[ ] PASSO 2: TESTAR A CHAVE SELETORA (Entrada)
    - Conecte a Chave Seletora na porta que você configurou para ela.
    - ELA ESTÁ FUNCIONANDO? Com o CCW conectado (Modo RUN online), 
      gire a chave fisicamente. Se o desenho ou valor da `Chave_Seletora` no 
      computador mudar de 0 para 1 (ou ficar Azul), o sinal de entrada está OK!

[ ] PASSO 3: ENTENDENDO O FECHAMENTO DO RELÉ NO DRIVE
    Como o seu CLP atua por Relé (chaves secas), as portas do CLP precisam 
    que você defina que "Pólo elétrico" o relé vai repassar para fora.
    
    A maioria absurda de drivers no mercado brasileiro lê sinais de forma 
    COMUM POSITIVA/Diferencial. 
    
    >> A LIGAÇÃO NA SAÍDA MECÂNICA FICA ASSIM <<
    
    1. O pino isolado Comum do Grupo de Saídas do seu Micro850 relé (costuma 
       chamar CM0 / CM1) deve ser jampeado/ligado no cabo do Positivo (+) da fonte. 
       (Atenção: A maioria dos drivers de passo lê 5V direto. Se você for usar fonte
       24V no motor, olhe se o Drive aceita 24V no sinal. Se ele vier escrito
       só "5V", você precisará colocar resistores de +- 2KOhms na linha, ou usar 
       tensão 5V para alimentar esse CM0 do sinal do relé).
       
    2. Borne 00 do CLP -> Ligar no pino [PUL+] (ou STEP+) do Drive.
    3. Borne 03 do CLP -> Ligar no pino [DIR+] do Drive.
    4. Borne 06 do CLP -> Ligar no pino [ENA+] (ou EN+) do Drive.

    5. O Terra do Sinal: Junte os pinos [PUL-], [DIR-] e [ENA-] na base do Drive.
       Conecte esse grupão no negativo/GND da sua fonte elétrica usada ali no CM0.

[ ] PASSO 4: AUDITORIA DOS LEDS (Bancada de LEDs do CLP)
    - Vire a chave (Mande ligar a lógica!). 
      Se o código "Prog1" estiver rodando mesmo, você deve observar:
      > O LED da Saída "06" (Enable) deve acender SÓLIDO O TEMPO TODO.
      > O LED da porta "00" (Pulse) deverá começar a PISCAR infinitamente!
        É aqui que você tem que escutar nitidamente o "Tique-Taque"
        dos relés no plástico do Micro850!

[ ] PASSO 5: A REAÇÃO FÍSICA FINAL DO MOTOR E DRIVE
    - Trava Eletromagnética: No instante que o relé "06" atracar, vá no
      motor de passo físico e tente girar o pino/eixo dele. Ele tem que
      estar duro como pedra (fase ativada/holding).
    - O Giro: Com o relé "00" "metralhando" e pescando os Timers que fizemos, o
      seu motor vai começar a vibrar e girar levemente a exatos parcos RPM's, 
      comprovando que sua lógica transbordou e controlou o mundo real.
