library IEEE;
USE ieee.numeric_bit.ALL;

entity testbench_multiplicador is
end testbench_multiplicador;

architecture tb_arch of testbench_multiplicador is
    signal clk : bit;
    signal Va, Vb : bit_vector(3 downto 0);
    signal Reset, Start : bit;
    signal Vresult : bit_vector(7 downto 0);
    signal Ready : bit;

    component multiplicador_modificado
        port ( Va, Vb : in bit_vector(3 downto 0);
               Clock : in bit;
               Reset : in bit;
               Start : in bit;
               Vresult : out bit_vector(7 downto 0);
               Ready : out bit);
    end component;

    begin
        DUT: multiplicador_modificado
            port map (Va => Va, Vb => Vb, Clock => clk, Reset => Reset,
                      Start => Start, Vresult => Vresult, Ready => Ready);

        clk_process: process
        begin
            while now < 200 ns loop
                clk <= not clk;
                wait for 5 ns;
            end loop;
            wait;
        end process clk_process;

        simulation_process: process
        begin
            -- Operation 1: 1101 * 1011
            -- Expected Result: 10001111
            Va <= "1101";
            Vb <= "1011";
            Reset <= '1';
            Start <= '0';
            wait for 10 ns;

            Reset <= '0';
            wait for 10 ns;

            Start <= '1';
            wait for 10 ns;

            wait until Ready = '1';
            if Vresult = "10001111" then
                report "Operation 1 Successful" severity note;
            else
                report "Error in Operation 1" severity error;
            end if;

            -- Operation 2: 0111 * 0001
            -- Expected Result: 00000111
            Va <= "0111";
            Vb <= "0001";
            Reset <= '1';
            Start <= '0';
            wait for 10 ns;

            Reset <= '0';
            wait for 10 ns;

            Start <= '1';
            wait for 10 ns;

            wait until Ready = '1';
            if Vresult = "00000111" then
                report "Operation 2 Successful" severity note;
            else
                report "Error in Operation 2" severity error;
            end if;

            -- Operation 3: 0111 * 0010
            -- Expected Result: 00001110
            Va <= "0111";
            Vb <= "0010";
            Reset <= '1';
            Start <= '0';
            wait for 10 ns;

            Reset <= '0';
            wait for 10 ns;

            Start <= '1';
            wait for 10 ns;

            wait until Ready = '1';
            if Vresult = "00001110" then
                report "Operation 3 Successful" severity note;
            else
                report "Error in Operation 3" severity error;
            end if;

            -- Operation 4: 0111 * 0100
            -- Expected Result: 00011100
            Va <= "0111";
            Vb <= "0100";
            Reset <= '1';
            Start <= '0';
            wait for 10 ns;

            Reset <= '0';
            wait for 10 ns;

            Start <= '1';
            wait for 10 ns;

            wait until Ready = '1';
            if Vresult = "00011100" then
                report "Operation 4 Successful" severity note;
            else
                report "Error in Operation 4" severity error;
            end if;

            -- Operation 5: 0111 * 1001
            -- Expected Result: 00111111
            Va <= "0111";
            Vb <= "1001";
            Reset <= '1';
            Start <= '0';
            wait for 10 ns;

            Reset <= '0';
            wait for 10 ns;

            Start <= '1';
            wait for 10 ns;

            wait until Ready = '1';
            if Vresult = "00111111" then
                report "Operation 5 Successful" severity note;
            else
                report "Error in Operation 5" severity error;
            end if;

            -- Operation 6: 1111 * 1111
            -- Expected Result: 11100001
            Va <= "1111";
            Vb <= "1111";
            Reset <= '1';
            Start <= '0';
            wait for 10 ns;

            Reset <= '0';
            wait for 10 ns;

            Start <= '1';
            wait for 10 ns;

            wait until Ready = '1';
            if Vresult = "11100001" then
                report "Operation 6 Successful" severity note;
            else
                report "Error in Operation 6" severity error;
            end if;

            -- Operation 7: 0000 * 0000
            -- Expected Result: 00000000
            Va <= "0000";
            Vb <= "0000";
            Reset <= '1';
            Start <= '0';
            wait for 10 ns;

            Reset <= '0';
            wait for 10 ns;

            Start <= '1';
            wait for 10 ns;

            wait until Ready = '1';
            if Vresult = "00000000" then
                report "Operation 7 Successful" severity note;
            else
                report "Error in Operation 7" severity error;
            end if;

             -- Operation 8: 1101 * 0000
            -- Expected Result: 00000000
            Va <= "1011";
            Vb <= "0000";
            Reset <= '1';
            Start <= '0';
            wait for 10 ns;

            Reset <= '0';
            wait for 10 ns;

            Start <= '1';
            wait for 10 ns;

            wait until Ready = '1';
            if Vresult = "00000000" then
                report "Operation 8 Successful" severity note;
            else
                report "Error in Operation 8" severity error;
            end if;

             -- Operation 9: 0000 * 1011
            -- Expected Result: 00000000
            Va <= "0000";
            Vb <= "1011";
            Reset <= '1';
            Start <= '0';
            wait for 10 ns;

            Reset <= '0';
            wait for 10 ns;

            Start <= '1';
            wait for 10 ns;

            wait until Ready = '1';
            if Vresult = "00000000" then
                report "Operation 9 Successful" severity note;
            else
                report "Error in Operation 9" severity error;
            end if;

            wait;
        end process simulation_process;

end tb_arch;