library IEEE;
use IEEE.std_logic_1164.all;


entity TRCUT_with_LFSR is port (       clock : in std_logic;
                                       selected_mode : in std_logic;
                                       serial_output : out std_logic);
end entity;


architecture noFault of TRCUT_with_LFSR is


   component LFSR_8_BITS is
       port(
           clock : in std_logic;
           q     : out std_logic
       );
   end component;




   component Test_Ready_Circuit_Under_Test is
       port (
           clock           : in std_logic;
           serial_input    : in std_logic;
           selected_mode   : in std_logic;
           serial_output   : out std_logic
       );
   end component;


   signal lfsr_output : std_logic := 'X';
   signal gated_clock : std_logic ;


begin




   LFSR : LFSR_8_BITS
       port map(
           clock => gated_clock,
           q     => lfsr_output
       );


   TRCUT: entity work.Test_Ready_Circuit_Under_Test(noFault)
       port map (
           clock           => clock,
           serial_input    => lfsr_output,
           selected_mode   => selected_mode,
           serial_output   => serial_output
       );




   process(clock, selected_mode) is
   begin
       if selected_mode = '1' then gated_clock <= clock; else gated_clock <= '0'; end if;


   end process;
end architecture noFault;