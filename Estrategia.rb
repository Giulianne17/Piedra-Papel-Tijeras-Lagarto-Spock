=begin
    Clase Estrategia: permite generar una jugada a partir de jugadas anteriores.
    Cuenta con las subclases Manual, Uniforme, Sesgada, Copiar y Pensar, para representar
    distintos tipos de estrategias.

    Integrantes:
    - Angélica Acosta 14-10005.
    - Giulianne Tavano 13-11389.
=end

require_relative "Jugada.rb"

class Estrategia
    attr_reader :nombre, :oponente, :actual, :proxima
    $random = Random.new(42)

    def asignarOponente(op)
        @oponente = op
    end
    
    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@self.to_s
    end

    def reset
    end

    def jugar
        @actual = @proxima
    end

    private

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

    def getActual
        return @actual
    end
end

class Manual < Estrategia

    #Método constructor
	def initialize()
        @nombre = "Manual"
    end

    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

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

class Uniforme < Estrategia
    attr_reader :movimientos_posibles
    
    #Método constructor
	def initialize(list)
        @nombre = "Uniforme"
        @movimientos_posibles = check_list(list)
    end

    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

    def prox()
        @index = $random.rand(0..@movimientos_posibles.length)
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

class Sesgada < Estrategia
    attr_reader :nombre, :movimientos_posibles, :actual, :index
    
    #Método constructor
	def initialize(list)
        @nombre = "Sesgada"
        @movimientos_posibles = check_list(list)
    end

    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

    def prox()
        @index = $random.rand(0..@movimientos_posibles.length)
        @actual = @movimientos_posibles[index].to_s
        if @actual == "Piedra"
            return Piedra.new()
        elsif @actual == "Papel"
            return Papel.new()
        elsif @actual == "Tijera"
            return Tijera.new()
        elsif @actual == "Lagarto"
            return Lagarto.new()
        elsif @actual == "Spock"
            return Spock.new()
        end
    end
    
end

class Copiar < Estrategia
    
    #Método constructor
	def initialize(inicial)
        @nombre = "Copiar" 
        @actual = inicial
    end

    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

    def prox()
        @proxima = @oponente.getActual()
        return @proxima
    end
    
end

class Pensar < Estrategia
    attr_reader :contadores
    
    #Método constructor
	def initialize()
        @nombre = "Pensar" 
        @contadores = { :Piedra => 0, :Papel => 0, :Tijeras => 0,
            :Lagarto => 0, :Spock => 0}
    end

    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

    def prox()
        if @oponente.getActual().is_a?(Piedra)
            @contadores[:Piedra]= @contadores[:Piedra] + 1
        elsif @oponente.getActual().is_a?(Papel)
            @contadores[:Papel]= @contadores[:Papel] + 1
        elsif @oponente.getActual().is_a?(Tijera)
            @contadores[:Tijera]= @contadores[:Tijera] + 1
        elsif @oponente.getActual().is_a?(Lagarto)
            @contadores[:Lagarto]= @contadores[:Lagarto] + 1
        elsif @oponente.getActual().is_a?(Spock)
            @contadores[:Spock]= @contadores[:Spock] + 1
        end

        suma = 0
        @contadores.each do |jugada, repeticion|
            suma = suma + repeticion
        end

        index = $random.rand(0..suma)
        
        if index.between?(0, @contadores[:Piedra])
            @proxima = Piedra.new()
        end

        return @proxima
    end
    
end

=begin
lista = [ :Piedra, :Papel, :Tijera, :Lagarto, :Spock ]
estra = Uniforme.new(lista)
puts estra.prox().to_s

mapa = { :Piedra => 2, :Papel => 5, :Tijeras => 4, :Lagarto => 3, :Spock => 1}
=end