=begin
    Clase Jugada: representa la noción de la jugada ejecutada por un jugador.
    Cuenta con las subclases Piedra, Papel, Tijera, Lagarto y Spock, para representar los
    elementos específicos.

    Integrantes:
    - Angélica Acosta 14-10005.
    - Giulianne Tavano 13-11389.
=end

class Jugada
    attr_reader :inv, :seña

    #Método constructor
	def initialize(x,y)
		@inv, @seña = x, y
	end
    
    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@inv.to_s
    end

    #Método puntos que determina el resultado de la jugada entre el invocante y la jugada j.
    def puntos(j)
        if j.seña.nombre==@seña.nombre
            return "[0,0]"
        elsif @seña.nombre=="Piedra" && (j.seña.nombre=="Tijera" || j.seña.nombre=="Lagarto")
            return "[1,0]"
        elsif @seña.nombre=="Piedra" && (j.seña.nombre=="Papel" || j.seña.nombre=="Spock")
            return "[0,1]"
        elsif @seña.nombre=="Papel" && (j.seña.nombre=="Spock" || j.seña.nombre=="Piedra")
            return "[1,0]"
        elsif @seña.nombre=="Papel" && (j.seña.nombre=="Tijera" || j.seña.nombre=="Lagarto")
            return "[0,1]"
        elsif @seña.nombre=="Tijera" && (j.seña.nombre=="Papel" || j.seña.nombre=="Lagarto")
            return "[1,0]"
        elsif @seña.nombre=="Tijera" && (j.seña.nombre=="Spock" || j.seña.nombre=="Piedra")
            return "[0,1]"
        elsif @seña.nombre=="Lagarto" && (j.seña.nombre=="Papel" || j.seña.nombre=="Spock")
            return "[1,0]"
        elsif @seña.nombre=="Lagarto" && (j.seña.nombre=="Tijera" || j.seña.nombre=="Piedra")
            return "[0,1]"
        elsif @seña.nombre=="Spock" && (j.seña.nombre=="Piedra" || j.seña.nombre=="Tijera")
            return "[1,0]"
        elsif @seña.nombre=="Spock" && (j.seña.nombre=="Lagarto" || j.seña.nombre=="Papel")
            return "[0,1]"
        else
            return "[0,0]"
        end
    end 
end

class Piedra < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Piedra"
    end
end

class Papel < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Papel"
	end
end

class Tijera < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Tijera"
	end
end

class Lagarto < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Lagarto"
	end
end

class Spock < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Spock"
	end
end

=begin
puts "Prueba"
a=Piedra.new()
puts a.nombre
b=Jugada.new("Giuli",a)
puts b.seña.nombre
puts b.to_s()
d=Lagarto.new()
c=Jugada.new("Angey",d)
puts b.puntos(c)
=end