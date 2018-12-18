=begin
    Clase Jugada: representa la noción de la jugada ejecutada por un jugador.
    Cuenta con las subclases Piedra, Papel, Tijera, Lagarto y Spock, para representar los
    elementos específicos.

    Integrantes:
    - Angélica Acosta 14-10005.
    - Giulianne Tavano 13-11389.
=end

class Jugada
    
    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@self.to_s
    end

end

class Piedra < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Piedra"
    end

    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

    #Método puntos que determina el resultado de la jugada entre el invocante y la jugada j.
    def puntos(j)
        if (j.nombre=="Tijera" || j.nombre=="Lagarto")
            return "[1,0]"
        elsif (j.nombre=="Papel" || j.nombre=="Spock")
            return "[0,1]"
        else
            return "[0,0]"
        end
    end     
end

class Papel < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Papel"
    end
    
    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end
    
    #Método puntos que determina el resultado de la jugada entre el invocante y la jugada j.
    def puntos(j)
        if (j.nombre=="Spock" || j.nombre=="Piedra")
            return "[1,0]"
        elsif (j.nombre=="Tijera" || j.nombre=="Lagarto")
            return "[0,1]"
        else
            return "[0,0]"
        end
    end   
end

class Tijera < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Tijera"
    end
    
    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

    #Método puntos que determina el resultado de la jugada entre el invocante y la jugada j.
    def puntos(j)
        if (j.seña.nombre=="Papel" || j.seña.nombre=="Lagarto")
            return "[1,0]"
        elsif (j.seña.nombre=="Spock" || j.seña.nombre=="Piedra")
            return "[0,1]"
        else
            return "[0,0]"
        end
    end     
end

class Lagarto < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Lagarto"
    end

    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

    #Método puntos que determina el resultado de la jugada entre el invocante y la jugada j.
    def puntos(j)
        if (j.seña.nombre=="Papel" || j.seña.nombre=="Spock")
            return "[1,0]"
        elsif (j.seña.nombre=="Tijera" || j.seña.nombre=="Piedra")
            return "[0,1]"
        else
            return "[0,0]"
        end
    end  
end

class Spock < Jugada
    attr_reader :nombre

    #Método constructor
	def initialize()
        @nombre = "Spock"
    end

    #Método to_s que permite mostrar el invocante como un String.
    def to_s
		@nombre
    end

    #Método puntos que determina el resultado de la jugada entre el invocante y la jugada j.
    def puntos(j)
        if (j.seña.nombre=="Piedra" || j.seña.nombre=="Tijera")
            return "[1,0]"
        elsif (j.seña.nombre=="Lagarto" || j.seña.nombre=="Papel")
            return "[0,1]"
        else
            return "[0,0]"
        end
    end 
end

=begin
puts "Prueba"
a=Piedra.new()
puts a.nombre
puts a.to_s()
d=Lagarto.new()
puts a.puntos(d)
=end