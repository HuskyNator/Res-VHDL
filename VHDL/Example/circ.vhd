
package CircPackage is
  generic (type T; L: integer);
  type Tarray is array (natural range <>) of T;
  function selectorSize(L : integer) return integer;
end package;
package body CircPackge is
  function selectorSize(L : integer) return integer is
    variable power : integer := 1;
    variable count : integer := 0;
  begin
    while power < L loop
      power := power sll 1;
      count := count + 1;
    end loop;
    return count;
  end function;
end package body;

use work.CircPackage.selectorSize;
entity CircE is
  generic (
    type T;
    type Tarray;
    L : integer);
  port (
    clock : in Clock;
    a, b : in Tarray(L - 1 downto 0);
    selector : in bit_vector(selectorSize(L) - 1 downto 0);
    res : out Tarray(1 downto 0)
  );
  constant S : integer := selectorSize(L);
end entity CircE;

use IEEE.numeric_std.all;
architecture CircA of CircE is
  signal selected : Tarray(1 downto 0);
  signal index : integer;
begin
  index <= to_integer(unsigned(selector));
  selected(0) <= a(index);
  selected(1) <= b(index);

  process
  begin
    wait until rising_edge(clock.value);
    res(0) <= selected(0);
  end process;

  process
  begin
    wait until falling_edge(clock.value);
    res(1) <= selected(1);
    report "B = " & integer'image(selected(1)) & " at " & time'image(now) & "(clock#" & integer'image(clock.count) & ")";
  end process;
end architecture;