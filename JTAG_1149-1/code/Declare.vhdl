library ieee;
use ieee.std_logic_1164.all;
package Declarations is
type state_type is (

TEST_LOGIC_RESET, 
RUN_TEST,
SELECT_DR_SCAN,
CAPTURE_DR,
SHIFT_DR,
EXIT_1_DR,
PAUSE_DR,
EXIT_2_DR,
UPDATE_DR,
SELECT_IR_SCAN,
CAPTURE_IR,
SHIFT_IR,
EXIT_1_IR,
PAUSE_IR,
EXIT_2_IR,
UPDATE_IR);
end Declarations;