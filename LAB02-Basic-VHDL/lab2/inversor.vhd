
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity inversor is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (3 downto 0) );
end inversor;

architecture rtl of inversor is

begin
	B(0) <= A(3) when S = '1' else A(0);
	B(1) <= A(2) when S = '1' else A(1);
	B(2) <= A(1) when S = '1' else A(2);
	B(3) <= A(0) when S = '1' else A(3);

end rtl;

