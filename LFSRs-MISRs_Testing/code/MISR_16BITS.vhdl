library IEEE;
use IEEE.std_logic_1164.all;


entity MISR_16BITS is
   port(clock:in std_logic; MISR_set: in std_logic; serial_input_MISR: std_logic;  q:out std_logic);
end;


architecture RTL of MISR_16BITS is
   signal LFSR: std_logic_vector(15 downto 0) := (others => '1');
begin
   process(clock)
       variable feedback: std_logic;
   begin
       if MISR_set = '0' then
           if clock'EVENT and clock='1' then
               feedback := LFSR(15);
               LFSR(0) <= serial_input_MISR;
               LFSR(1) <= LFSR(0);
               LFSR(2) <= LFSR(1) xor feedback;
               LFSR(3) <= LFSR(2) xor feedback;
               LFSR(4) <= LFSR(3);
               LFSR(5) <= LFSR(4) xor feedback;
               LFSR(6) <= LFSR(5);
               LFSR(7) <= LFSR(6);
               LFSR(8) <= LFSR(7);
               LFSR(9) <= LFSR(8);
               LFSR(10) <= LFSR(9);
               LFSR(11) <= LFSR(10);
               LFSR(12) <= LFSR(11);
               LFSR(13) <= LFSR(12);
               LFSR(14) <= LFSR(13);
               LFSR(15) <= LFSR(14);
           end if;
       else LFSR <= (others => '1'); end if;
       q <= LFSR(15);
   end process;
end;