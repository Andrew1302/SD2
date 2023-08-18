library IEEE;
use ieee.numeric_bit.all;

entity multiplicador_modificado is
    port ( Va, Vb : in bit_vector(3 downto 0);
           Clock : in bit;
           Reset : in bit;
           Start : in bit;
           Vresult : out bit_vector(7 downto 0);
           Ready : out bit);
end entity;

architecture comportamento of multiplicador_modificado is

    signal Vresult_signal: bit_vector(7 downto 0);
    signal Ready_signal: bit;

    begin
        process(Clock, Reset)  
        
        variable resultado : unsigned(4 downto 0);
        variable resultadoparcial : unsigned(3 downto 0);
        variable extras : unsigned(3 downto 0);
        variable cont : integer;
        variable multiplicando: unsigned(3 downto 0);
        variable multiplicador: bit_vector(3 downto 0);

        begin
            if Reset = '1' then
                resultado := "00000";
                resultadoparcial := "0000";
                extras := "0000";
                multiplicando := unsigned(Va);
                multiplicador := Vb;
                cont := 0;
                Ready_signal <= '0';
            elsif (rising_edge(Clock) and Start = '1') then
                if cont < 4 then
                    if (multiplicador(0) = '1') then
                        resultado := resultado(4 downto 0) + ('0' & multiplicando(3 downto 0));
                        resultadoparcial(3 downto 0) := resultadoparcial(3 downto 0) + multiplicando(3 downto 0);
                    end if;
                    extras(cont) := resultadoparcial(0);
                    -- Condicao para pegar o carry
                    if (resultado(4) = '1') then
                        resultadoparcial := '1' & resultadoparcial(3 downto 1);
                    else
                        resultadoparcial := '0' & resultadoparcial(3 downto 1);
                    end if;
                    resultado := '0' & resultadoparcial(3 downto 0); -- Reinicia o carry
                    multiplicador := '0' & multiplicador(3 downto 1);
                    cont := cont + 1; -- Contador incrementado
                    Vresult_signal <= bit_vector(resultadoparcial(3 downto 0) & extras(3 downto 0));
                    if (Start = '1' and cont = 4) then
                        Ready_signal <= '1';
                    end if;
                end if;
            end if;            
        end process;
        
        -- Atribuicoes das variaveis de saida
        Vresult <= Vresult_signal;
        Ready <= Ready_signal;

end architecture;