library IEEE;
use IEEE.std_logic_1164.all;

entity IR_REG_2bits_JTAG is port(           Reset:  in std_logic;
                                                        Shift_IR : in std_logic;
                                                        Capture_Data : in std_logic_vector(1 downto 0);
                                                        TDI : in std_logic;
                                                        Clock_IR : in std_logic;
                                                        Update_IR : in std_logic;
                                                        TDO : out std_logic;
                                                        Instruction_Bits : out std_logic_vector(1 downto 0));
end entity;


architecture desing of IR_REG_2bits_JTAG is
    
    component IR_REG_JTAG
        port (
            Reset : in std_logic;
            Shift_IR : in std_logic;
            Capture_Data : in std_logic;
            TDI : in std_logic;
            Clock_IR : in std_logic;
            Update_IR : in std_logic;
            TDO : out std_logic;
            Instruction_Bit : out std_logic
        );
    end component;
     
     
     signal tdo_bit_1 : std_logic;
     
     begin
     
     bit_1: IR_REG_JTAG
        port map (
            Reset => Reset,
            Shift_IR => Shift_IR,
            Capture_Data => Capture_Data(0),
            TDI => TDI,
            Clock_IR => Clock_IR,
            Update_IR => Update_IR,
            TDO => tdo_bit_1,
            Instruction_Bit => Instruction_Bits(0)
        );
     
     
     bit_2: IR_REG_JTAG
        port map (
            Reset => Reset,
            Shift_IR => Shift_IR,
            Capture_Data => Capture_Data(1),
            TDI => tdo_bit_1,
            Clock_IR => Clock_IR,
            Update_IR => Update_IR,
            TDO => TDO,
            Instruction_Bit => Instruction_Bits(1)
        );
     
     

end architecture;