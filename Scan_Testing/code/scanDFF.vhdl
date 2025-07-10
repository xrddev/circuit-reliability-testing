library IEEE;
use IEEE.std_logic_1164.all;


entity scanDFF is port( clock           : in std_logic;
                          d_in           : in std_logic;
                          serial_input     : in std_logic;
                          q_out          : out std_logic;
                          selected_mode    : in std_logic);
end entity;


architecture behavior of scanDFF is


   signal reg : std_logic := 'X';


begin


   process(clock)
   begin
       if rising_edge(clock) then
           case selected_mode is
               when '0'    => reg <= d_in;
               when '1'    => reg <= serial_input;
               when others => reg <= 'X';
           end case;
       end if;
   end process;


   q_out <= reg;


end architecture;