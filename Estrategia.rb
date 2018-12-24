=begin
    Clase Estrategia: permite generar una jugada a partir de jugadas anteriores.
    Cuenta con las subclases Manual, Uniforme, Sesgada, Copiar y Pensar, para representar
    distintos tipos de estrategias.

    Integrantes:
    - Angélica Acosta 14-10005.
    - Giulianne Tavano 13-11389.
=end

require_relative "Jugada.rb"

##
# Clase de la cual heredarán todos los tipos de estrategias
# Los atributos actual y proxima se refieren a la seña que se esta jugando (actual),
# y la seña que será jugada en la próxima ronda.
class Estrategia
    attr_reader :nombre, :oponente, :actual, :proxima
    $random = Random.new(42)
    ##
    # Metodo asignarOponente, se guarda la estrategia del oponente
    def asignarOponente(op)
        @oponente = op 
    end
    
    ##
    # Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

    def reset
    end

    ##
    # Metodo jugar: Se juega la próxima jugada 
    def jugar
        @actual = @proxima
    end

    ##
    # Metodo check_list:
    # Determina si la lista pasada como parámetro es válida, es decir,
    # las jugadas son permitidas por el juego.
    def check_list(list)
        valid = true
        simbolos = [ :Piedra, :Papel, :Tijera, :Lagarto, :Spock ]
        list.each do |jugada|
            if !(simbolos.include? jugada)
                valid = false
            end
        end
        
        if valid
            return list.uniq
        else
            raise 'La lista de movimientos posibles es inválida'
        end
    end

    ##
    # Metodo getActual: obtiene el actual
    def getActual
        return @actual
    end
end

##
# Subclase Manual, representa la estrategia Manual
class Manual < Estrategia

    ##
    #Método constructor
	def initialize()
        @nombre = "Manual"
    end

    ##
    # Metodo prox(m), Recibe como parametro una jugada
    def prox(m)
        if m.is_a?(Piedra)
            @proxima = Piedra.new()
        elsif m.is_a?(Papel)
            @proxima = Papel.new()
        elsif m.is_a?(Tijera)
            @proxima = Tijera.new()
        elsif m.is_a?(Lagarto)
            @proxima = Lagarto.new()
        elsif m.is_a?(Spock)
            @proxima = Spock.new()
        end
        return @proxima
    end

end

##
# Subclase Uniforme, representa la estrategia Uniforme
class Uniforme < Estrategia
    attr_reader :movimientos_posibles
    
    ##
    #Método constructor
	def initialize(list)
        @nombre = "Uniforme"
        @movimientos_posibles = check_list(list)
    end

    ##
    # Metodo prox(), calcula la prox jugada.
    def prox()
        # Selecciona al azar la proxima jugada
        @index = $random.rand(0..@movimientos_posibles.length)

        # Obtiene la jugada, dentro de las jugadas posibles, que se encuentra en la posicion seleccionada
        aux = @movimientos_posibles[@index].to_s

        if aux == "Piedra"
            @proxima = Piedra.new()
        elsif aux == "Papel"
            @proxima = Papel.new()
        elsif aux == "Tijera"
            @proxima = Tijera.new()
        elsif aux == "Lagarto"
            @proxima = Lagarto.new()
        elsif aux == "Spock"
            @proxima = Spock.new()
        end
        return @proxima
    end
    
end

##
# Subclase Sesgada, representa la estrategia Sesgada
class Sesgada < Estrategia
    attr_reader :nombre, :probabilidades, :total_probabilidades, :actual, :index
    
    ##
    #Método constructor
	def initialize(list)
        @nombre = "Sesgada"
        check_list(list.keys)
        @probabilidades = list
        @total_probabilidades = 0
        list.each do |key, value|
            @total_probabilidades += value
        end
    end

    ##
    # Metodo prox()
    # El proximo se elige de acuerdo a la distribucion sesgada de los datos que se
    # encuentran en el mapa de movimientos posibles con sus probabilidades asociadas
    def prox()

        # Selecciona un numero al azar dentro del total de probabilidades
        @index = $random.rand(0..@total_probabilidades)

        # Se recorre el mapa de movimientos posibles con sus probabilidades.
        # Si el numero seleccionado al azar es mayor que la suma de la probabilidad
        # actual mas la probabilidad de los movimientos anteriores en la lista
        # entonces seguimos buscando el próximo movimiento. Pararemos cuando el 
        # numero seleccionado al azar sea menor o igual a la sumatoria antes mencionada.
        aux1 = @probabilidades.values[0]
        aux2 = 0
        list_length = @probabilidades.values.length
        while (@index > aux1 && aux2 < list_length-1)
            aux2 += 1
            aux1 += @probabilidades.values[aux2]
        end
        aux = @probabilidades.keys[aux2].to_s
        
        if aux == "Piedra"
            @proxima = Piedra.new()
        elsif aux == "Papel"
            @proxima = Papel.new()
        elsif aux == "Tijera"
            @proxima = Tijera.new()
        elsif aux == "Lagarto"
            @proxima = Lagarto.new()
        elsif aux == "Spock"
            @proxima = Spock.new()
        end
        return @proxima
    end
    
end

##
# Subclase Copiar, representa la estrategia Copiar
class Copiar < Estrategia
    
    ##
    #Método constructor
	def initialize(inicial)
        @nombre = "Copiar" 
        @actual = inicial
        @inicio = inicial
    end

    ##
    # Metodo prox()
    # Se obtiene la jugada actual del otro jugador, es decir, del oponente.
    def prox()
        @proxima = @oponente.getActual()
        return @proxima
    end
    
    ##
    #Metodo reset, reinicia el actual
    def reset()
        @actual =@inicio
    end
end

##
# Subclase Pensar, representa la estrategia Pensar
class Pensar < Estrategia
    attr_reader :contadores
    
    ##
    #Método constructor
	def initialize()
        @nombre = "Pensar" 
        @contadores = { :Piedra => 0, :Papel => 0, :Tijera => 0, :Lagarto => 0, :Spock => 0}
    end

    ##
    # Metodo prox(), calcula el prox
    def prox()

        # Aumenta la frecuencia de acuerdo a la jugada actual del oponente
        if @oponente.getActual().is_a?(Piedra)
            @contadores[:Piedra] = @contadores[:Piedra] + 1
        elsif @oponente.getActual().is_a?(Papel)
            @contadores[:Papel] = @contadores[:Papel] + 1
        elsif @oponente.getActual().is_a?(Tijera)
            @contadores[:Tijera] = @contadores[:Tijera] + 1
        elsif @oponente.getActual().is_a?(Lagarto)
            @contadores[:Lagarto] = @contadores[:Lagarto] + 1
        elsif @oponente.getActual().is_a?(Spock)
            @contadores[:Spock] = @contadores[:Spock] + 1
        end

        # Crea una lista con las frecuencias acumuladas
        suma = 0
        acumulado = []
        @contadores.each do |jugada, repeticion|
            suma = suma + repeticion
            acumulado.push(suma)
        end

        # Elige un numero al azar entre 0 y la frecuencia total menos uno
        index = $random.rand(0..suma)
        
        # De acuerdo al numero elegido al azar selecciona una jugada
        if index.between?(0, acumulado[0])
            @proxima = Piedra.new()
        elsif index.between?(acumulado[0], acumulado[1])
            @proxima = Papel.new()
        elsif index.between?(acumulado[1], acumulado[2])
            @proxima = Tijera.new()
        elsif index.between?(acumulado[2], acumulado[3])
            @proxima = Lagarto.new()
        elsif index.between?(acumulado[3], acumulado[4])
            @proxima = Spock.new()
        end

        return @proxima
    end
    
    ##
    #Metodo reset, reinicia los contadores
    def reset()
        @contadores = { :Piedra => 0, :Papel => 0, :Tijeras => 0,
            :Lagarto => 0, :Spock => 0}
    end
end
