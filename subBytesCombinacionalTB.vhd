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

entity subBytesCombinacionalTB is

end entity;
  
architecture behavior of subBytesCombinacionalTB is	
	
	component subBytesCombinacional is
	 port(
	   clock : in std_logic;
	   reset : in std_logic;
	   bloco_in  : in Bloco; 
     bloco_out : out Bloco 
	 );
  end component;
  
  signal  c   :  std_logic := '1';
	signal  r   :  std_logic := '0';
	signal  entrada  :  Bloco := (others =>(others => '0')); 
  signal  saida :  Bloco := (others =>(others => '0'));

  begin
  
  componente : subBytesCombinacional port map (clock => c, reset => r, bloco_in => entrada, bloco_out => saida);

  
  --estimulo
  c <= (not c) after 20ns;
  
  estimulo: process
    begin
     
      entrada <= ("01100000","10000001","01001111","11011100",
                  "00100010","00101010","10010000","10001000",
                  "01000110","11101110","10111000","00010100",
                  "11011110","01011110","00001011","11011011");
      wait for 100 ns;
  
  end process estimulo;
  
end behavior;