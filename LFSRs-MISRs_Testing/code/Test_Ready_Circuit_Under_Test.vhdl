library IEEE;
use IEEE.std_logic_1164.all;


entity Test_Ready_Circuit_Under_Test is port(   clock        : in std_logic;
                                                serial_input   : in std_logic;
                                                selected_mode  : in std_logic;
                                                serial_output  : out std_logic);
end entity;




architecture noFault of Test_Ready_Circuit_Under_Test is


   component scanDFF is
       port (
           clock : in std_logic;
           d_in : in std_logic;
           serial_input : in std_logic;
           q_out : out std_logic;
           selected_mode : in std_logic
       );
   end component;


   component Circuit_Under_Test is
       port (
           a, b, c, d : in std_logic;
           i, j : out std_logic
       );
   end component;




   signal i_signal, j_signal, dff_q_out_1, dff_q_out_2, dff_q_out_3, dff_q_out_4 : std_logic := 'X';




begin


   CUT : entity work.Circuit_Under_Test(noFault)
       port map (
           a => dff_q_out_1,
           b => dff_q_out_2,
           c => dff_q_out_3,
           d => dff_q_out_4,
           i => i_signal,
           j => j_signal
       );


   scanDFF_S1 : scanDFF
       port map (
           clock => clock,
           d_in => j_signal,
           serial_input => serial_input,
           q_out => dff_q_out_1,
           selected_mode => selected_mode
       );


   scanDFF_S2 : scanDFF
       port map (
           clock => clock,
           d_in => i_signal,
           serial_input => dff_q_out_1,
           q_out => dff_q_out_2,
           selected_mode => selected_mode
       );


   scanDFF_S3 : scanDFF
       port map (
           clock => clock,
           d_in => dff_q_out_3,
           serial_input => dff_q_out_2,
           q_out => dff_q_out_3,
           selected_mode => selected_mode
       );


   scanDFF_S4 : scanDFF
       port map (
           clock => clock,
           d_in => dff_q_out_4,
           serial_input => dff_q_out_3,
           q_out => dff_q_out_4,
           selected_mode => selected_mode
       );


   serial_output <= dff_q_out_4;


end architecture noFault;


--------------------------
--------------------------
--------------------------


architecture stuckAtOne of Test_Ready_Circuit_Under_Test is


   component scanDFF is
       port (
           clock : in std_logic;
           d_in : in std_logic;
           serial_input : in std_logic;
           q_out : out std_logic;
           selected_mode : in std_logic
       );
   end component;


   component Circuit_Under_Test is
       port (
           a, b, c, d : in std_logic;
           i, j : out std_logic
       );
   end component;




   signal i_signal, j_signal, dff_q_out_1, dff_q_out_2, dff_q_out_3, dff_q_out_4 : std_logic := 'X';


begin


   CUT : entity work.Circuit_Under_Test(stuckAtOne)
       port map (
           a => dff_q_out_1,
           b => dff_q_out_2,
           c => dff_q_out_3,
           d => dff_q_out_4,
           i => i_signal,
           j => j_signal
       );


   scanDFF_S1 : scanDFF
       port map (
           clock => clock,
           d_in => j_signal,
           serial_input => serial_input,
           q_out => dff_q_out_1,
           selected_mode => selected_mode
       );


   scanDFF_S2 : scanDFF
       port map (
           clock => clock,
           d_in => i_signal,
           serial_input => dff_q_out_1,
           q_out => dff_q_out_2,
           selected_mode => selected_mode
       );


   scanDFF_S3 : scanDFF
       port map (
           clock => clock,
           d_in => dff_q_out_3,
           serial_input => dff_q_out_2,
           q_out => dff_q_out_3,
           selected_mode => selected_mode
       );


   scanDFF_S4 : scanDFF
       port map (
           clock => clock,
           d_in => dff_q_out_4,
           serial_input => dff_q_out_3,
           q_out => dff_q_out_4,
           selected_mode => selected_mode
       );


   serial_output <= dff_q_out_4;


end architecture stuckAtOne;


--------------------------
--------------------------
--------------------------
architecture stuckAtZero of Test_Ready_Circuit_Under_Test is


   component scanDFF is
       port (
           clock : in std_logic;
           d_in : in std_logic;
           serial_input : in std_logic;
           q_out : out std_logic;
           selected_mode : in std_logic
       );
   end component;


   component Circuit_Under_Test is
       port (
           a, b, c, d : in std_logic;
           i, j : out std_logic
       );
   end component;




   signal i_signal, j_signal, dff_q_out_1, dff_q_out_2, dff_q_out_3, dff_q_out_4 : std_logic := 'X';


begin


   CUT : entity work.Circuit_Under_Test(stuckAtZero)
       port map (
           a => dff_q_out_1,
           b => dff_q_out_2,
           c => dff_q_out_3,
           d => dff_q_out_4,
           i => i_signal,
           j => j_signal
       );


   scanDFF_S1 : scanDFF
       port map (
           clock => clock,
           d_in => j_signal,
           serial_input => serial_input,
           q_out => dff_q_out_1,
           selected_mode => selected_mode
       );


   scanDFF_S2 : scanDFF
       port map (
           clock => clock,
           d_in => i_signal,
           serial_input => dff_q_out_1,
           q_out => dff_q_out_2,
           selected_mode => selected_mode
       );


   scanDFF_S3 : scanDFF
       port map (
           clock => clock,
           d_in => dff_q_out_3,
           serial_input => dff_q_out_2,
           q_out => dff_q_out_3,
           selected_mode => selected_mode
       );


   scanDFF_S4 : scanDFF
       port map (
           clock => clock,
           d_in => dff_q_out_4,
           serial_input => dff_q_out_3,
           q_out => dff_q_out_4,
           selected_mode => selected_mode
       );


   serial_output <= dff_q_out_4;


end architecture stuckAtZero;