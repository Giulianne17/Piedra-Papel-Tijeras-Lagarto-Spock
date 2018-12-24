=begin
    Clase Partida: representa la noción de la partida del juego. 
    Debe construirse recibiendo un mapa con los nombres y estrategias de los jugadores

    Integrantes:
    - Angélica Acosta 14-10005.
    - Giulianne Tavano 13-11389.
=end

require_relative 'Jugada.rb'
require_relative 'Estrategia.rb'

##
# Clase Partida: representa la noción de la partida del juego. 
class Partida
    # Mapa con las especificaciones iniciales del Juego, representa el estado inicial
    attr_reader :mapainicio
    # Mapa con el estado actual del Juego
    attr_reader :mapaactual
    # Mapa con las estrategias de los jugadores y el puntaje
    attr_reader :map

    ##
    # Metodo constructor, que un mapa con los nombres 
    # y estrategias de los jugadores
    def initialize(mapa)
        mapatemp = []
        mapa.each_value {|value| mapatemp.push(value) }
        # Verificando que hay exactamente dos jugadores 
        if mapa.length == 2
            # Verificando que en efecto son estrategias, si alguna no lo es se lanza excepcion
            if (!mapatemp[0].is_a?(Manual) && !mapatemp[0].is_a?(Uniforme) && !mapatemp[0].is_a?(Sesgada) && !mapatemp[0].is_a?(Copiar) &&  !mapatemp[0].is_a?(Pensar)) ||
                (!mapatemp[1].is_a?(Manual) && !mapatemp[1].is_a?(Uniforme) && !mapatemp[1].is_a?(Sesgada) && !mapatemp[1].is_a?(Copiar) &&  !mapatemp[1].is_a?(Pensar))
                raise "Ambos elementos deben ser estrategias (Manual, Uniforme, Sesgada, Copiar o Pensar) "
            else
                ml={}
                # Construyendo los mapas que permiten el control de la clase
                for i in mapa.keys
                    ml=ml.merge({i =>0})
                end
                rond = {:Rounds => 0}
                @map=mapa
                @mapainicio=ml.merge(rond)
                @mapaactual=ml.merge(rond)

                estrategia1=@map[@map.keys[0]]
                estrategia2=@map[@map.keys[1]]
        
                #Se asignan los oponentes
                estrategia1.asignarOponente(estrategia2)
                estrategia2.asignarOponente(estrategia1)
            end
        else
            raise "Deben haber dos estrategias (Manual, Uniforme, Sesgada, Copiar o Pensar)"
        end
    end

    ##
    # Metodo rondas con n un entero positivo, debe completar n rondas 
    # en el juego y producir un mapa indicando los puntos obtenidos
    # por cada jugador y la cantidad de rondas jugadas.
    def rondas(n)
        $i = 0
        $num = n
        estrategia1=@map[@map.keys[0]]
        estrategia2=@map[@map.keys[1]]

        # Verifica si alguna estrategia es Copiar o Manual
        if estrategia1.is_a?(Copiar)
            if !estrategia2.is_a?(Manual) && !estrategia2.is_a?(Copiar)
                estrategia2.prox()
            elsif estrategia2.is_a?(Manual)
                puts "Jugador1"
                m=preguntaManual()
                estrategia2.prox(m)
            end
            pasosLoop(estrategia1,estrategia2)
            $i +=1
        end
        if estrategia2.is_a?(Copiar)
            if !estrategia1.is_a?(Manual) && !estrategia1.is_a?(Copiar)
                estrategia1.prox()
            elsif estrategia1.is_a?(Manual)
                puts "Jugador1"
                m=preguntaManual()
                estrategia1.prox(m)
            end
            pasosLoop(estrategia1,estrategia2)
            $i +=1
        end     
        # Ciclo principal de la funcion rondas.   
        begin
            pasosProximo(estrategia1,estrategia2)
            pasosLoop(estrategia1,estrategia2)
            $i +=1
        end while $i < $num
        #Actualiza la cantidad de rondas.
        cambioRondas(n)
    end

    ##
    # Metodo cambioPuntajes, que dado un string n, actualiza 
    # el puntaje de los jugadores en el mapa.
    def cambioPuntajes(n)
        puntaje1=@mapaactual[@mapaactual.keys[0]]
        puntaje2=@mapaactual[@mapaactual.keys[1]]
        if n=="[1,0]"
            puntaje1=1+puntaje1
            @mapaactual[@mapaactual.keys[0]]=puntaje1
            @mapaactual
        elsif n=="[0,1]"
            puntaje2=1+puntaje2
            @mapaactual[@mapaactual.keys[1]]=puntaje2
            @mapaactual
        end
    end

    ##
    # Metodo cambioRondas, que dado un valor n, suma la cantidad
    # de rondas actuales con n y actualiza el valor en el mapa.
    def cambioRondas(n)
        rond=@mapaactual[@mapaactual.keys[2]]
        @mapaactual[@mapaactual.keys[2]]=rond+n
        @mapaactual
    end

    ##
    # Metodo preguntaManual, que hace la pregunta de cual va  a
    # ser la prox jugada del jugador si tiene la estrategia Manual,
    # retorna la jugada.
    def preguntaManual()
        puts "¿Cuál es la seña que quieres hacer?"
        puts "1.-Piedra 2.-Papel 3.-Tijera 4.-Lagarto 5.-Spock"
        l= gets.chomp
        if l=="1"
            Piedra.new()
        elsif l=="2"
            Papel.new()
        elsif l=="3"
            Tijera.new()
        elsif l=="4"
            Lagarto.new()
        elsif l=="5"
            Spock.new()  
        else
            raise "Ingreso algo erroneo" 
        end
    end

    ##
    # Metodo alzanzar, con n un entero positivo, debe completar
    # tantas rondas como sea necesario hasta que alguno de los 
    # jugadores alcance n puntos, produciendo un mapa indicando 
    # los puntos obtenidos por cada jugador y la cantidad de 
    # rondas jugadas.
    def alcanzar (n)
        i = @mapaactual[@mapaactual.keys[0]]
        j = @mapaactual[@mapaactual.keys[1]]
        count = 0
        estrategia1=@map[@map.keys[0]]
        estrategia2=@map[@map.keys[1]]

        # Verifica si alguna estrategia es Copiar o Manual
        if estrategia1.is_a?(Copiar)
            if !estrategia2.is_a?(Manual) && !estrategia2.is_a?(Copiar)
                estrategia2.prox()
            elsif estrategia2.is_a?(Manual)
                puts "Jugador2"
                m=preguntaManual()
                estrategia2.prox(m)
            end
            pasosLoop(estrategia1,estrategia2)
            i= @mapaactual[@mapaactual.keys[0]]
            j= @mapaactual[@mapaactual.keys[1]]
            count=count+1
        end
        if estrategia2.is_a?(Copiar)
            if !estrategia1.is_a?(Manual) && !estrategia1.is_a?(Copiar)
                estrategia1.prox()
            elsif estrategia1.is_a?(Manual)
                puts "Jugador1"
                m=preguntaManual()
                estrategia1.prox(m)
            end
            pasosLoop(estrategia1,estrategia2)
            i= @mapaactual[@mapaactual.keys[0]]
            j= @mapaactual[@mapaactual.keys[1]]
            count=count+1
        end
        # Ciclo principal de la funcion alcanzar.
        begin
            pasosProximo(estrategia1,estrategia2)
            pasosLoop(estrategia1,estrategia2)
            i= @mapaactual[@mapaactual.keys[0]]
            j= @mapaactual[@mapaactual.keys[1]]
            count=count+1
        end while i < n && j< n
        # Actualiza la cantidad de rondas.
        cambioRondas(count)
    end

    ##
    # Metodo pasosProximo, que recibe las estrategias de
    # los jugadores y les aplica el metodo prox.
    def pasosProximo(estrategia1,estrategia2)
        if !estrategia1.is_a?(Manual)
            estrategia1.prox()
        else
            puts "Jugador1"
            m=preguntaManual()
            estrategia1.prox(m)
        end
        if !estrategia2.is_a?(Manual)
            estrategia2.prox()
        else
            puts "Jugador2"
            m=preguntaManual()
            estrategia2.prox(m)
        end
    end

    ##
    # Metodo pasosLoop, que recibe las dos estrategias de los 
    # jugadores. Termina de realizar los pasos de la jugada,
    # calcula los puntos y los actualiza en el mapa para luego
    # retornarlo.
    def pasosLoop(estrategia1,estrategia2)
        if !estrategia1.is_a?(Copiar)
            if (estrategia1.actual.nil? && !estrategia1.is_a?(Manual))
                estrategia1.prox()
            end
            estrategia1.jugar()
        end
        if !estrategia2.is_a?(Copiar)
            if (estrategia2.actual.nil? && !estrategia2.is_a?(Manual))
                estrategia2.prox()
            end
            estrategia2.jugar()
        end
        #Calcula los puntos de la jugada
        p=estrategia1.actual.puntos(estrategia2.actual)
        # Actualiza los Puntajes
        cambioPuntajes(p)
    end

    ##
    # Metodo reiniciar, que lleva el juego a su estado inicial.
    def reiniciar
        reset()
        @mapaactual=@mapainicio

    end

    ##
    # Metodo reset, que hace reset a las estrategias de los jugadores.
    def reset
        @map[@map.keys[0]].reset
        @map[@map.keys[1]].reset
    end
end
