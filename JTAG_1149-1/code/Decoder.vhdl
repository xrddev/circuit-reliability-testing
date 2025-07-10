library IEEE;
use IEEE.std_logic_1164.all;
use work.Declarations.all;

entity Decoder is port(				Instruction : in std_logic_vector(1 downto 0);
											Mode : out std_logic;
											Data_Registers_Select : out std_logic;
											TDO_Select : out std_logic);
end entity;

architecture desing of Decoder is

	-- Mandatory Instructions
	constant BYPASS : std_logic_vector(1 downto 0) := "11";
	constant SAMPLE_PRELOAD : std_logic_vector(1 downto 0) := "01";
	constant EXTEST : std_logic_vector(1 downto 0) := "00";
	

begin

	TDO_Select 				 <= '0' when Instruction = BYPASS 			else
									 '0' when Instruction = SAMPLE_PRELOAD else 
									 '0' when Instruction = EXTEST 			else 	'X';
									 
									 
	DATa_Registers_Select <= '0' when Instruction = BYPASS else
									 '1' when Instruction = SAMPLE_PRELOAD else 
									 '1' when Instruction = EXTEST else 'X';

	
	Mode <= '0' when Instruction = SAMPLE_PRELOAD else 
			  '1' when Instruction = EXTEST else 'X';
	


end architecture;

