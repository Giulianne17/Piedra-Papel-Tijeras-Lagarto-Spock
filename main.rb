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
    puts "3.-Salir"
    a=gets.chomp
    verTipo(a,p)
end

def verEstrategia(b)
    if b=="1"
        Manual.new()
    elsif b=="2"
        puts "Ingrese una lista de posibles movimientos"
        puts "Ej: [:Piedra, :Papel, :Tijeras, :Lagarto, :Spock]"
        f=gets.chomp
        f=f.to_sym
        Uniforme.new(f)
    elsif b=="3"
        puts "Ingrese el mapa de movimientos posibles y sus probabilidades asociadas"
        puts "Ej: { :Piedra => 2, :Papel => 5, :Tijeras => 4,:Lagarto => 3, :Spock => 1}"
        f=gets.chomp
        Sesgada.new(eval(f))
    elsif b=="4"
        puts "¿Cuál va a ser tu jugada inicial?"
        puts "1.-Piedra 2.-Papel 3.-Tijeras 4.-Lagarto 5.-Spock"
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

puts "Bienvenidos al juego Piedra, Papel, Tijeras, Lagarto, Spock"
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
    puts "Estas son las instrucciones."
else
    puts "Adios"
end
