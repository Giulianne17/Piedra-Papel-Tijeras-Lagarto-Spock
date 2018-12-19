require_relative 'Jugada.rb'
require_relative 'Estrategia.rb'

class Partida
    attr_reader :mapainicio, :mapaactual, :map

    def initialize(mapa)
        mapatemp = []
        mapa.each_value {|value| mapatemp.push(value) }
        if mapa.length == 2
            if (!mapatemp[0].is_a?(Manual) && !mapatemp[0].is_a?(Uniforme) && !mapatemp[0].is_a?(Sesgada) && !mapatemp[0].is_a?(Copiar) &&  !mapatemp[0].is_a?(Pensar)) ||
                (!mapatemp[1].is_a?(Manual) && !mapatemp[1].is_a?(Uniforme) && !mapatemp[1].is_a?(Sesgada) && !mapatemp[1].is_a?(Copiar) &&  !mapatemp[1].is_a?(Pensar))
                raise "Ambos elementos deben ser estrategias (Manual, Uniforme, Sesgada, Copiar o Pensar) "
            else
                ml={}
                for i in mapa.keys
                    ml=ml.merge({i =>0})
                end
                rond = {:Rounds => 0}
                @map=mapa
                @mapainicio=ml.merge(rond)
                @mapaactual=ml.merge(rond)
            end
        else
            raise "Deben haber dos estrategias (Manual, Uniforme, Sesgada, Copiar o Pensar)"
        end
    end

    def rondas(n)
        $i = 0
        $num = n
        begin
            estrategia1=@map[@map.keys[0]]
            estrategia2=@map[@map.keys[1]]
            #prox() ambos
            #jugar() ambos
            #puntos con los actuales
            #cambiarPuntajes
            puts("Inside the loop i = #$i" )
            $i +=1
        end while $i < $num
        cambioRondas(n)
    end

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

    def cambioRondas(n)
        rond=@mapaactual[@mapaactual.keys[2]]
        @mapaactual[@mapaactual.keys[2]]=rond+1
        @mapaactual
    end

    def alcanzar (n)
    end

    def reiniciar
        @mapaactual=@mapainicio
    end
end

=begin
s=Manual.new()
s3=Manual.new()
m2= { :Deepthought => s, :Multivac => s3 }
a=Partida.new(m2)
puts a.mapainicio
puts a.mapaactual
h= { :D => 1, :M => 2 }
puts h[:D]
puts h.keys[0]
puts "hey"
puts a.cambioPuntajes("[1,0]")
=end
=begin
s1=Estrategia.new()
s2=Estrategia.new()
m= { :Deepthought => s1, :Multivac => s2 }
Partida.new(m)
m1= { :Deepthought => s1, :Multivac => s2, :Multivac1 => s2 }
puts m1.length
Partida.new(m1)
#=end
=begin
s=Manual.new()
s3=Manual.new()
m2= { :Deepthought => s, :Multivac => s3 }
puts m2.keys
ml={}
for i in m2.keys
    ml=ml.merge({i =>0})
 end
another_hash = {:Rounds => 0}
ml=ml.merge(another_hash)
puts ml
=end