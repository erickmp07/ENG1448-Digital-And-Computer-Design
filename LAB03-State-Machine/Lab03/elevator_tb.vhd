LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY elevator_tb IS
END elevator_tb;
 
ARCHITECTURE behavior OF elevator_tb IS 
 
    COMPONENT elevator
    PORT(
         CLK : IN  std_logic;
         BTN_UP : IN  std_logic;
         BTN_DOWN : IN  std_logic;
         SENSOR_UP : IN  std_logic;
         SENSOR_DOWN : IN  std_logic;
         MOTOR_UP : OUT  std_logic;
         MOTOR_DOWN : OUT  std_logic;
         LED_UP : OUT  std_logic;
         LED_DOWN : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal BTN_UP : std_logic := '0';
   signal BTN_DOWN : std_logic := '0';
   signal SENSOR_UP : std_logic := '0';
   signal SENSOR_DOWN : std_logic := '0';

 	--Outputs
   signal MOTOR_UP : std_logic;
   signal MOTOR_DOWN : std_logic;
   signal LED_UP : std_logic;
   signal LED_DOWN : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: elevator PORT MAP (
          CLK => CLK,
          BTN_UP => BTN_UP,
          BTN_DOWN => BTN_DOWN,
          SENSOR_UP => SENSOR_UP,
          SENSOR_DOWN => SENSOR_DOWN,
          MOTOR_UP => MOTOR_UP,
          MOTOR_DOWN => MOTOR_DOWN,
          LED_UP => LED_UP,
          LED_DOWN => LED_DOWN
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin
		-- Tries to move down when the elevator is on the first floor
      wait for 50 ns;
		BTN_UP <= '0';
		BTN_DOWN <= '1';
		SENSOR_UP <= '0';
		SENSOR_DOWN <= '1';
		
		--  Moves up when the elevator is on the first floor
		wait for 50 ns;
		BTN_UP <= '1';
		BTN_DOWN <= '0';
		SENSOR_DOWN <= '1';
		
		-- While is moving up, release button up
		wait for 50 ns;
		BTN_UP <= '0';
		SENSOR_DOWN <= '0';
		
		-- Arrives on the second floor
		wait for 50 ns;
		SENSOR_UP <= '1';
		
		-- Tries to move up when the elevator is on the second floor
		wait for 50 ns;
		BTN_UP <= '1';
		
		-- Moves down when the elevator is on the second floor
		wait for 50 ns;
		BTN_UP <= '0';
		BTN_DOWN <= '1';
		
		-- While is moving down, release button down
		wait for 50 ns;
		BTN_DOWN <= '0';
		SENSOR_UP <= '0';
		
		-- Arrives on the first floor
		wait for 50 ns;
		SENSOR_DOWN <= '1';
		
		-- Moves up when the elevator is on the first floor
		wait for 50 ns;
		BTN_UP <= '1';
		
		-- Moving up
		wait for 50 ns;
		SENSOR_DOWN <= '0';
		
		-- While is moving up, release button up and press button down
		wait for 50 ns;
		BTN_UP <= '0';
		BTN_DOWN <= '1';
		
		-- Arrives second floor
		wait for 50 ns;
		SENSOR_UP <= '1';
		
		-- Moves down when the elevator is on the second floor
		wait for 50 ns;
		BTN_DOWN <= '1';
		
		-- While is moving down, release button down
		wait for 50 ns;
		BTN_DOWN <= '0';
		SENSOR_UP <= '0';
		
		-- Arrives first floor
		wait for 50 ns;
		SENSOR_DOWN <= '1';
		wait;
   end process;

END;
