library IEEE;
use IEEE.std_logic_1164.all;


entity TRCUT_with_MISR is port (       selected_mode : in std_logic;
                                       clock : in std_logic;
                                       MISR_set: in std_logic;
                                       serial_output : out std_logic;
                                       error_Injection_mode : in std_logic);
end entity;


architecture noFault of TRCUT_with_MISR is
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




   component MISR_16BITS
       port (
           clock : in std_logic;
           q : out std_logic;
           MISR_set: in std_logic;
           serial_input_MISR: in std_logic
       );
   end component;








   signal LFSR_serial_output ,TRCUT_serial_output , xorTAP , MISR_serial_output: std_logic := '1';
   signal gated_clock : std_logic ;




begin


   LFSR : LFSR_8_BITS
       port map(
           clock => gated_clock,
           q     => LFSR_serial_output
       );


   TRCUT: entity work.Test_Ready_Circuit_Under_Test(noFault)
       port map (
           clock           => clock,
           serial_input    => LFSR_serial_output,
           selected_mode   => selected_mode,
           serial_output   => TRCUT_serial_output
       );


   MISR : MISR_16BITS
       port map (
           clock => gated_clock,
           q => MISR_serial_output,
           MISR_set => MISR_set,
           serial_input_MISR => xorTAP
       );




   process(clock, TRCUT_serial_output, MISR_serial_output) is
   begin
       if selected_mode = '1' then gated_clock <= clock;
       else gated_clock <= '0';
       end if;
       xorTAP <= TRCUT_serial_output xor error_Injection_mode xor MISR_serial_output;
   end process;


   serial_output <= MISR_serial_output;


end architecture noFault;




-------------
--------------
--------------


architecture stuckAtOne of TRCUT_with_MISR is
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




   component MISR_16BITS
       port (
           clock : in std_logic;
           q : out std_logic;
           MISR_set: in std_logic;
           serial_input_MISR: in std_logic
       );
   end component;


   signal LFSR_serial_output ,TRCUT_serial_output , xorTAP , MISR_serial_output: std_logic := '1';
   signal gated_clock : std_logic ;




begin


   LFSR : LFSR_8_BITS
       port map(
           clock => gated_clock,
           q     => LFSR_serial_output
       );


   TRCUT: entity work.Test_Ready_Circuit_Under_Test(stuckAtOne)
       port map (
           clock           => clock,
           serial_input    => LFSR_serial_output,
           selected_mode   => selected_mode,
           serial_output   => TRCUT_serial_output
       );


   MISR : MISR_16BITS
       port map (
           clock => gated_clock,
           q => MISR_serial_output,
           MISR_set => MISR_set,
           serial_input_MISR => xorTAP
       );




   process(clock, TRCUT_serial_output, MISR_serial_output) is
   begin
       if selected_mode = '1' then gated_clock <= clock;
       else gated_clock <= '0';
       end if;
       xorTAP <= TRCUT_serial_output xor error_Injection_mode xor MISR_serial_output;
   end process;


   serial_output <= MISR_serial_output;


end architecture stuckAtOne;


------------
------------
architecture stuckAtZero of TRCUT_with_MISR is
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




   component MISR_16BITS
       port (
           clock : in std_logic;
           q : out std_logic;
           MISR_set: in std_logic;
           serial_input_MISR: in std_logic
       );
   end component;


   signal LFSR_serial_output ,TRCUT_serial_output , xorTAP , MISR_serial_output: std_logic := '1';
   signal gated_clock : std_logic ;




begin


   LFSR : LFSR_8_BITS
       port map(
           clock => gated_clock,
           q     => LFSR_serial_output
       );


   TRCUT: entity work.Test_Ready_Circuit_Under_Test(stuckAtZero)
       port map (
           clock           => clock,
           serial_input    => LFSR_serial_output,
           selected_mode   => selected_mode,
           serial_output   => TRCUT_serial_output
       );


   MISR : MISR_16BITS
       port map (
           clock => gated_clock,
           q => MISR_serial_output,
           MISR_set => MISR_set,
           serial_input_MISR => xorTAP
       );




   process(clock, TRCUT_serial_output, MISR_serial_output) is
   begin
       if selected_mode = '1' then gated_clock <= clock;
       else gated_clock <= '0';
       end if;
       xorTAP <= TRCUT_serial_output xor error_Injection_mode xor MISR_serial_output;
   end process;


   serial_output <= MISR_serial_output;


end architecture stuckAtZero;
