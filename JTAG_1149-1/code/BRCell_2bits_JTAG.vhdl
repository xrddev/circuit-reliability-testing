library IEEE;
use IEEE.std_logic_1164.all;

entity BRCell_2bits_JTAG is port(			Parallel_Input : in std_logic_vector(1 downto 0);
														Shift_DR : in std_logic;
														Shift_IN : in std_logic;
														Shift_OUT : out std_logic;
														Clock_DR : in std_logic;
														Update_DR : in std_logic;
														Mode : in std_logic;
														Parallel_Output : out std_logic_vector(1 downto 0));
end entity;

architecture desing of BRCell_2bits_JTAG is

	component BR_CELL_JTAG
        port (
            Parallel_Input   : in std_logic;
            Shift_DR         : in std_logic;
            Shift_IN         : in std_logic;
            Shift_OUT        : out std_logic;
            Clock_DR         : in std_logic;
            Update_DR        : in std_logic;
            Mode             : in std_logic;
            Parallel_Output  : out std_logic
        );
    end component;

	 
	 signal a_shift_out : std_logic;
	 
begin
	
	a : BR_CELL_JTAG
        port map (
            Parallel_Input   => Parallel_Input(0),
            Shift_DR         => Shift_DR,
            Shift_IN         => Shift_IN,
            Shift_OUT        => a_shift_out,
            Clock_DR         => Clock_DR,
            Update_DR        => Update_DR,
            Mode             => Mode,
            Parallel_Output  => Parallel_Output(0)
        );
		  
	
	b : BR_CELL_JTAG
        port map (
            Parallel_Input   => Parallel_Input(1),
            Shift_DR         => Shift_DR,
            Shift_IN         => a_shift_out,
            Shift_OUT        => Shift_OUT,
            Clock_DR         => Clock_DR,
            Update_DR        => Update_DR,
            Mode             => Mode,
            Parallel_Output  => Parallel_Output(1)
        );
		  		

end architecture;


