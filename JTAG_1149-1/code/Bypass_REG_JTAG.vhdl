library IEEE;
use IEEE.std_logic_1164.all;

entity Bypass_REG_JTAG is  port(		TDI : in std_logic;
												Capture_DR : in std_logic;
												Clock_DR : in std_logic;
												TDO : out std_logic);
end entity;


architecture dataFlow of Bypass_REG_JTAG is


begin

	process(Clock_DR) is
	begin
		if rising_edge(Clock_DR) then
			TDO <= TDI and Capture_DR;
		end if;
	end process;
	

end architecture;