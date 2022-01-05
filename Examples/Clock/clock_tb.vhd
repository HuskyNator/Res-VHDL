use std.env.finish;

library ieee;
use ieee.std_logic_1164.all;

entity clock_tb is
end entity clock_tb;

architecture clock_tb of clock_tb is
  signal clock : std_logic;
begin
  CLK : entity work.clock generic map(halftime => 5 ns) port map(clk => clock);
  process
  begin
    wait for 100 ns;
    finish;
  end process;
end architecture;