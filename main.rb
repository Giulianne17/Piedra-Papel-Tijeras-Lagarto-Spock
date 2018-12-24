require_relative 'Jugada.rb'
require_relative 'Estrategia.rb'
require_relative 'Partida.rb'

def opciones()
    puts "1.-Iniciar el juego"
    puts "2.-Ver instrucciones"
    puts "3.-Salir"
end

def opcionesTipo(p)
    puts "1.-Rondas"
    puts "2.-Alcanzar"
    puts "3.-Reset"
    puts "4.-Salir"
    a=gets.chomp
    verTipo(a,p)
end

def verEstrategia(b)
    if b=="1"
        Manual.new()
    elsif b=="2"
        puts "Ingrese una lista de posibles movimientos"
        puts "Ej: Piedra, Papel, Tijera, Lagarto, Spock"
        f=gets.chomp
        f=f.split(%r{,\s*})
        list = []
        f.each do |string|
            list.push(string.to_sym)
        end
        Uniforme.new(list)
    elsif b=="3"
        puts "Ingrese el mapa de movimientos posibles y sus probabilidades asociadas"
        puts "Ej: { :Piedra => 2, :Papel => 5, :Tijera => 4,:Lagarto => 3, :Spock => 1}"
        f=gets.chomp
        Sesgada.new(eval(f))
    elsif b=="4"
        puts "¿Cuál va a ser tu jugada inicial?"
        puts "1.-Piedra 2.-Papel 3.-Tijera 4.-Lagarto 5.-Spock"
        d=gets.chomp
        e=verJugada(d)
        Copiar.new(e)
    elsif b=="5"
        Pensar.new()
    else
        raise "No es una opción"
    end
end

def verJugada(b)
    if b=="1"
        Piedra.new()
    elsif b=="2"
        Papel.new()
    elsif b=="3"
        Tijera.new()
    elsif b=="4"
        Lagarto.new()
    elsif b=="5"
        Spock.new()
    else
        raise "No es una opción"
    end
end

def verTipo(a,p)
    if a=="1"
        puts "Cantidad de rondas: "
        b=gets.chomp
        puts p.rondas(b.to_i)
    elsif a=="2"
        puts "Hasta alcanzar la puntuación: "
        b=gets.chomp
        puts p.alcanzar(b.to_i)
    elsif a=="3"
        p.reset()
        opcionesTipo(p)
    elsif a=="4"
        puts "Adios"
        a
    else
        raise "Opcion inválida"
    end
end

def juego(p)
    puts "Inicia el juego"
    puts "1.-Rondas"
    puts "2.-Alcanzar"
    a=gets.chomp
    verTipo(a,p)
    begin
        a=opcionesTipo(p)
    end while  !a=="3"
end

def principal()
    puts "Bienvenidos al juego Piedra, Papel, Tijera, Lagarto, Spock"
    opciones()
    a= gets.chomp
    if a=="1"
        puts "Jugador 1. Seleccione tipo de estrategia"
        puts "1.-Manual 2.-Uniforme 3.-Sesgada 4.-Copiar 5.-Pensar"
        b=gets.chomp  
        e1=verEstrategia(b)

        puts "Jugador 2. Seleccione tipo de estrategia"
        puts "1.-Manual 2.-Uniforme 3.-Sesgada 4.-Copiar 5.-Pensar"
        c=gets.chomp
        e2=verEstrategia(c)

        m={ :Jugador1 => e1, :Jugador2 => e2 }
        p=Partida.new(m)
        juego(p)
    elsif a=="2"
        puts "Estas jugando \"Piedra, Papel, Tijeras, Lagarto, Spock\""
        puts "Este juego es de dos jugadores, cada uno tendrá una estrategia que genera la siguiente jugada automáticamente, a menos de que se escoja una partida manual."
        puts "ESTRATEGIAS"
        puts "\tManual: el jugador escoge cada jugada."
        puts "\tUniforme: la proxima jugada se escoge al azar."
        puts "\tSesgada: de acuerdo a la lista de probabilidades proporcionada por el jugador, se escoge una jugada."
        puts "\tCopiar: copia la jugada anterior del oponente."
        puts "\tPensar: analiza las frecuencias de cada jugada realizada por el oponente y elige de acuerdo a ellas."
        puts "GANAR"
        puts "Gana aquel que tenga la mayor puntuación al final de la partida. Se obtiene un punto por cada ronda ganada:"
        puts "\tPiedra: le gana a Tijera y a Lagarto"
        puts "\tPapel: le gana a Piedra y a Spock"
        puts "\tTijera: le gana a Papel y a Lagarto"
        puts "\tLagarto: le gana a Papel y a Spock"
        puts "\tSpock: le gana a Piedra y a Tijera"
        puts "Si ambos jugadores juegan la misma seña ninguno obtiene puntos en esa ronda.\n\n"
        principal()
    else
        puts "Adios"
    end
end

principal()