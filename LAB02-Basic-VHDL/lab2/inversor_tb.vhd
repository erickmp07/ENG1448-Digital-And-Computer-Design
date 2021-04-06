LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY inversor_tb IS
END inversor_tb;
 
ARCHITECTURE behavior OF inversor_tb IS 
   --Inputs
   signal A : std_logic_vector(3 downto 0);
   signal S : std_logic;
 	--Outputs
   signal B : std_logic_vector(3 downto 0);
	
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.inversor PORT MAP (
          A => A,
          S => S,
          B => B
        );

   -- Stimulus process
	A <= "0001", "0010" after 200 ns, "1001" after 400 ns, "0100" after 600 ns, "0110" after 800 ns;
	S <= '1', '0' after 100 ns ,  '1' after 200 ns,  '0' after 300 ns,  '1' after 400 ns , '0' after 500 ns,  '1' after 600 ns, '0' after 700 ns,  '1' after 800 ns, '0' after 900 ns;
END;
