library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity elevator is
    Port ( CLK : in  STD_LOGIC;
           BTN_UP : in  STD_LOGIC;
           BTN_DOWN : in  STD_LOGIC;
           SENSOR_UP : in  STD_LOGIC;
           SENSOR_DOWN : in  STD_LOGIC;
           MOTOR_UP : out  STD_LOGIC;
			  MOTOR_DOWN : out  STD_LOGIC;
           LED_UP : out  STD_LOGIC;
			  LED_DOWN : out  STD_LOGIC);
end elevator;

architecture rtl of elevator is
	type StateT is (Stopped, Moving_Up, Moving_Down);
	signal state, next_state: StateT := Stopped;
begin
	process(CLK) is
	begin
		if rising_edge(CLK) then
			state <= next_state;
		end if;
	end process;
	
	process(state, BTN_UP, BTN_DOWN, SENSOR_UP, SENSOR_DOWN) is
	begin
		case state is
			when Stopped =>
				if BTN_DOWN = '1' and SENSOR_DOWN = '1' then
					next_state <= Stopped;
				elsif BTN_UP = '1' and SENSOR_UP = '1' then
					next_state <= Stopped;
				elsif BTN_DOWN = '1' and SENSOR_UP = '1' then
					next_state <= Moving_Down;
				elsif BTN_UP = '1' and SENSOR_DOWN = '1' then
					next_state <= Moving_Up;
				elsif BTN_UP = '1' or BTN_DOWN = '1' then
					next_state <= Stopped;
				end if;
				
			when Moving_Up =>
				if (BTN_UP = '1' or BTN_DOWN = '1') and SENSOR_UP = '0' then
					next_state <= Moving_Up;
				elsif SENSOR_UP = '1' then
					next_state <= Stopped;
				end if;
				
			when Moving_Down =>
				if (BTN_UP = '1' or BTN_DOWN = '1') and SENSOR_DOWN = '0' then
					next_state <= Moving_Down;
				elsif SENSOR_DOWN = '1' then
					next_state <= Stopped;
				end if;
		end case;
	end process;
	
	MOTOR_UP <= '1' when state = Moving_Up else '0';
	MOTOR_DOWN <= '1' when state = Moving_Down else '0';
	LED_UP <= '1' when BTN_UP = '1' or state = Moving_Up else '0';
	LED_DOWN <= '1' when BTN_DOWN = '1' or state = Moving_Down else '0';
end rtl;