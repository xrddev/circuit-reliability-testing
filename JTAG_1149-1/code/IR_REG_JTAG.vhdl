library IEEE;
use IEEE.std_logic_1164.all;

entity IR_REG_JTAG is port(					Reset:  in std_logic;
														Shift_IR : in std_logic;
														Capture_Data : in std_logic;
														TDI : in std_logic;
														Clock_IR : in std_logic;
														Update_IR : in std_logic;
														TDO : out std_logic;
														Instruction_Bit : out std_logic);
end entity;


architecture desing of IR_REG_JTAG is

	signal mux , tdo_signal : std_logic;
	
	begin
	
	mux <=  	TDI when Shift_IR = '1' 			else 
				Capture_Data when Shift_IR = '0' else
				'X' when Shift_IR = 'X';
	
	
	TDO_FLIP_FLOP:
	process(clock_IR) is
	begin
		if rising_edge(clock_IR) then
			tdo_signal <= mux;
		end if;
	end process;
	
	
	Instruction_Bit_Flip_Flop:
	process(Reset, Update_IR) is 
	begin
		if Reset = '0' then Instruction_Bit <= '0';
		elsif rising_edge(Update_IR) then Instruction_Bit <= tdo_signal;
		end if;
	end process;
	
	
	TDO <= tdo_signal;

end architecture;