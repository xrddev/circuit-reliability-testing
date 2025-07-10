library IEEE;
use IEEE.std_logic_1164.all;

entity BR_CELL_JTAG is port(					Parallel_Input : in std_logic;
														Shift_DR : in std_logic;
														Shift_IN : in std_logic;
														Shift_OUT : out std_logic;
														Clock_DR : in std_logic;
														Update_DR : in std_logic;
														Mode : in std_logic;
														Parallel_Output : out std_logic);
end entity;

architecture desing of BR_CELL_JTAG is

	signal mux_1, CAP , UPD : std_logic;

begin

	mux_1 <= Shift_IN when SHIft_DR = '1' else
				Parallel_Input when Shift_DR = '0' else
				'X' when Shift_DR = 'X';
	
	
	Capture_Flip_Flop:
	process(Clock_DR) is
	begin
		if rising_edge(Clock_DR) then
			CAP <= mux_1;
		end if;
	end process;
	
	
	Update_Latch:
	process(Update_DR) is
	begin
		if rising_edge(Update_DR) then
			UPD <= CAP;
		end if;
	end process;
	
	
	Shift_OUT <= CAP;
	
	Parallel_Output <= UPD when Mode = '1' else
							 Parallel_Input when Mode = '0' else
							 'X' when Mode = 'X';
		

end architecture;


