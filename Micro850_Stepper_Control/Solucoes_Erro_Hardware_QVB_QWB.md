========================================================================
GUIA DE HARDWARE: MICRO850 (ERRO DE COMPATIBILIDADE QVB VS QWB)
========================================================================

O erro "O tipo real do controlador não corresponde ao tipo de controlador desse projeto" 
ocorre pois o projeto criado exige saídas a Transistor (modelo QVB ou QBB) para 
gerar os trens de pulsos extremamente rápidos (PTO) para controle de passo. 

No entanto, o CLP conectado fisicamente possui saídas a Relé (modelo QWB). 
Relés são chaves mecânicas lentas ("tec-tec") e a própria Rockwell bloqueia a 
configuração de blocos de movimento de alta frequência para essas saídas, pois 
danificariam ou vibrariam sutilmente.

COMO SEGUIR AGORA? DESCRIÇÃO DOS 3 CAMINHOS POSSÍVEIS:

1. TROCAR O CLP FÍSICO (Para aplicações produtivas)
------------------------------------------------------------------------
Se esta programação for para uma máquina real e o planejamento for direto da CPU, 
você precisará fisicamente de um modelo de Saída de Estado Sólido (Transistor), 
ou seja: 2080-L50E-24QVB ou 2080-L50E-24QBB.

2. USAR UM MÓDULO PLUG-IN "2080-MOT-HSC" (Para aproveitar o CLP atual)
------------------------------------------------------------------------
Se a compra de outro bloco de CLP estiver fora de questão, a solução é comprar 
o módulo de plugin "2080-MOT-HSC" (Módulo PTO/Contador Rápido). 
Você o "espeta" na frente do atual CLP a relé. Ele possui eletrônica dedicada 
de estado sólido ultrarrápido para suportar o PTO. No CCW, você passa a apontar 
a saída do Axis para as portas do módulo, e não mais as saídas embutidas da CPU.

3. USAR O SIMULADOR VIRTUAL (Para seguir estudando/desenvolvendo)
------------------------------------------------------------------------
Para validar imediatamente essa nossa lógica e observar o comportamento das variáveis 
(motor acelerando, freando) sem precisar lutar contra a barreira do hardware físico 
da bancada hoje:
   - Abra a ferramenta "Micro800 Simulator" no topo da janela do CCW.
   - Configure o simulador para criar um CLP virtual do exato modelo do nosso 
     projeto: "2080-L50E-24QVB".
   - Ligue o Simulador (Botão de Power/Play).
   - Volte ao projeto principal, indique no painel de Download que a rede 
     agora é o endereço IP do simulador (geralmente localhost / 127.0.0.1).
   - Dê o comando de Download. O controlador emulado aceitará as configurações do eixo!
