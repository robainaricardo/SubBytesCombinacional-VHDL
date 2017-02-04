--bibliotecas do pacote (tipos)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--pacote com tipos utilizados
package tipos is
  subtype ByteInt is std_logic_vector(0 to 7);
  type ByteArray is array (0 to 255) of ByteInt;
  type Bloco is array(0 to 15) of ByteInt;
end package tipos;

--bibliotecas d componente
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tipos.all; -- usa o pakege criado

entity subBytesCombinacional is
  
	port(
	  clock : in std_logic;
	  reset : in std_logic;
	  bloco_in  : in Bloco; -- bloco de entrada (a ser cifrado)
    bloco_out : out Bloco -- bloco de saida (ja cifrado)
	);
	
end entity;

architecture behavior of subBytesCombinacional is
  
  type tipoRam is array (0 to 255) of std_logic_vector (7 downto 0);
  
  
  --Tabela SBOX em bin�rio
  signal SBOX : tipoRam := (
  ---     0          1          2         3           4         5         6           7           8         9          A           B          C          D          E          F        
    "01100011","01111100","01110111","01111011","11110010","01101011","01101111","11000101","00110000","00000001","01100111","00101011","11111110","11010111","10101011","01110110",
    "11001010","10000010","11001001","01111101","11111010","01011001","01000111","11110000","10101101","11010100","10100010","10101111","10011100","10100100","01110010","11000000",
    "10110111","11111101","10010011","00100110","00110110","00111111","11110111","11001100","00110100","10100101","11100101","11110001","01110001","11011000","00110001","00010101",
    "00000100","11000111","00100011","11000011","00011000","10010110","00000101","10011010","00000111","00010010","10000000","11100010","11101011","00100111","10110010","01110101",
    "00001001","10000011","00101100","00011010","00011011","01101110","01011010","10100000","01010010","00111011","11010110","10110011","00101001","11100011","00101111","10000100",
    "01010011","11010001","00000000","11101101","00100000","11111100","10110001","01011011","01101010","11001011","10111110","00111001","01001010","01001100","01011000","11001111",
    "11010000","11101111","10101010","11111011","01000011","01001101","00110011","10000101","01000101","11111001","00000010","01111111","01010000","00111100","10011111","10101000",
    "01010001","10100011","01000000","10001111","10010010","10011101","00111000","11110101","10111100","10110110","11011010","00100001","00010000","11111111","11110011","11010010",
    "11001101","00001100","00010011","11101100","01011111","10010111","01000100","00010111","11000100","10100111","01111110","00111101","01100100","01011101","00011001","01110011",
    "01100000","10000001","01001111","11011100","00100010","00101010","10010000","10001000","01000110","11101110","10111000","00010100","11011110","01011110","00001011","11011011",
    "11100000","00110010","00111010","00001010","01001001","00000110","00100100","01011100","11000010","11010011","10101100","01100010","10010001","10010101","11100100","01111001",
    "11100111","11001000","00110111","01101101","10001101","11010101","01001110","10101001","01101100","01010110","11110100","11101010","01100101","01111010","10101110","00001000",
    "10111010","01111000","00100101","00101110","00011100","10100110","10110100","11000110","11101000","11011101","01110100","00011111","01001011","10111101","10001011","10001010",
    "01110000","00111110","10110101","01100110","01001000","00000011","11110110","00001110","01100001","00110101","01010111","10111001","10000110","11000001","00011101","10011110",
    "11100001","11111000","10011000","00010001","01101001","11011001","10001110","10010100","10011011","00011110","10000111","11101001","11001110","01010101","00101000","11011111",
    "10001100","10100001","10001001","00001101","10111111","11100110","01000010","01101000","01000001","10011001","00101101","00001111","10110000","01010100","10111011","00010110");

--declara��o dos sinais
  signal blocoIN : Bloco;     --sinal do bloco de entrada
  signal blocoOUT : Bloco;    --sinal do bloco de saida
  constant cte : unsigned(0 to 4):= "10000";  --sinal CONSTANTE valor 16, numero de colunas da tabela
                                          --utilizado para calcular o endereco do array durante a operacao

begin

  --blocoIN <= bloco_in;
  --bloco para teste(Antes do TESTEBANCH)
  --blocoIN <= ("01100000","10000001","01001111","11011100",
  --           "00100010","00101010","10010000","10001000",
  --          "01000110","11101110","10111000","00010100",
  --          "11011110","01011110","00001011","11011011");
  
  --Atribui a entrada ao sinal 
  blocoIN <= bloco_in;
  
  --processo combinacional que efetua a operacao de SUBBYTES do algoritmo AES
  --- saida[X] <= SBOX((16*To_Integer.X[0 to 3]) + To_Integer.X[4 to 7])
  blocoOUT(0) <= SBOX(to_integer( (cte * unsigned(blocoIN(0)(0 to 3)) ) + unsigned(blocoIN(0)(4 to 7)) ));
  blocoOUT(1) <= SBOX(to_integer( (cte * unsigned(blocoIN(1)(0 to 3)) ) + unsigned(blocoIN(1)(4 to 7)) ));  
  blocoOUT(2) <= SBOX(to_integer( (cte * unsigned(blocoIN(2)(0 to 3)) ) + unsigned(blocoIN(2)(4 to 7)) ));
  blocoOUT(3) <= SBOX(to_integer( (cte * unsigned(blocoIN(3)(0 to 3)) ) + unsigned(blocoIN(3)(4 to 7)) ));
  blocoOUT(4) <= SBOX(to_integer( (cte * unsigned(blocoIN(4)(0 to 3)) ) + unsigned(blocoIN(4)(4 to 7)) ));
  blocoOUT(5) <= SBOX(to_integer( (cte * unsigned(blocoIN(5)(0 to 3)) ) + unsigned(blocoIN(5)(4 to 7)) ));
  blocoOUT(6) <= SBOX(to_integer( (cte * unsigned(blocoIN(6)(0 to 3)) ) + unsigned(blocoIN(6)(4 to 7)) ));
  blocoOUT(7) <= SBOX(to_integer( (cte * unsigned(blocoIN(7)(0 to 3)) ) + unsigned(blocoIN(7)(4 to 7)) ));
  blocoOUT(8) <= SBOX(to_integer( (cte * unsigned(blocoIN(8)(0 to 3)) ) + unsigned(blocoIN(8)(4 to 7)) ));
  blocoOUT(9) <= SBOX(to_integer( (cte * unsigned(blocoIN(9)(0 to 3)) ) + unsigned(blocoIN(9)(4 to 7)) ));
  blocoOUT(10) <= SBOX(to_integer( (cte * unsigned(blocoIN(10)(0 to 3)) ) + unsigned(blocoIN(10)(4 to 7)) ));
  blocoOUT(11) <= SBOX(to_integer( (cte * unsigned(blocoIN(11)(0 to 3)) ) + unsigned(blocoIN(11)(4 to 7)) ));
  blocoOUT(12) <= SBOX(to_integer( (cte * unsigned(blocoIN(12)(0 to 3)) ) + unsigned(blocoIN(12)(4 to 7)) ));
  blocoOUT(13) <= SBOX(to_integer( (cte * unsigned(blocoIN(13)(0 to 3)) ) + unsigned(blocoIN(13)(4 to 7)) ));
  blocoOUT(14) <= SBOX(to_integer( (cte * unsigned(blocoIN(14)(0 to 3)) ) + unsigned(blocoIN(14)(4 to 7)) ));
  blocoOUT(15) <= SBOX(to_integer( (cte * unsigned(blocoIN(15)(0 to 3)) ) + unsigned(blocoIN(15)(4 to 7)) ));
  
  process (clock, reset)
	begin
		if (rising_edge(clock)) then
			if (reset = '1') then
				bloco_out <= (others =>(others => '0'));
			else 
				bloco_out <= blocoOUT;
			end if;
		end if;
 
  
  end process;
  
end behavior;