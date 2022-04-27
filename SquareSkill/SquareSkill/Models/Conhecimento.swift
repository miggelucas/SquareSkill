//
//  Conhecimento.swift
//  SquareSkill
//
//  Created by Lucas Migge de Barros on 05/04/22.
//

import Foundation

class Conhecimento {
    let nome : String
    let valorConceito : Float
    let valorVerbal : Float
    let valorMental : Float
    let crianca : Bool
    let adulto : Bool
    let idoso : Bool
    let tipoConhecimento : String
    
    init(nome : String, conceito : Float,
         verbal : Float, mental : Float,
         crianca : Bool, adulto : Bool, idoso : Bool, tipoConhecimento : String) {
             self.nome = nome
             self.valorConceito = conceito
             self.valorVerbal = verbal
             self.valorMental = mental
             self.crianca = crianca
             self.adulto = adulto
             self.idoso = idoso
             self.tipoConhecimento = tipoConhecimento
    }
    
    
    func modulaEscoreIdade(tipoEscore tipo : String ,escoreInicial escoreBase : Float, crianca  switchCrianca : Bool, adulto SwitchAdulto : Bool, idoso switchIdoso: Bool) -> Float {
        // ser capaz de ensinar ou não para diferentes grupos etários regula o escore
        // se capaz de explicar para crianças e/ou idosos recebe um bonus
        // não ser capaz de explicar para adultos recebe uma penalizacão
        var escore : Float
        escore = escoreBase
        
        // Pesos diferente com base no fator do escore
        if tipo == "conceito"{
            if switchCrianca {
                escore = escore * 1.2
            }
            
            if !SwitchAdulto {
                escore = escore * 0.6
            }
            
            if switchIdoso {
                escore = escore * 1.1
                
            }
        } else { // comunicaçao
            if switchCrianca {
                escore = escore * 1.1
            }
            
            if !SwitchAdulto {
                escore = escore * 0.8
            }
            
            if switchIdoso {
                escore = escore * 1.4
                
            }
        }
        return Float(escore)
    }
    
    func modulaEscoreTipo(tipoEscore : String, escoreInicial escoreBase : Float) -> Float{
        // compensa a diferença natural de escores para os fatores com base no tipo do escore
        // se for um conhecimento teórico, o escore de comunicação recebe um bonus
        // Se for um conhecimento prático, o escore de conceito recebe um bonus
        // se for um conhecimento híbrido, o escore dos fatores permanece o mesmo
        
       var escoreAjustado : Float = 0.0
       
       if tipoConhecimento == "Conhecimento teórico" {
           if tipoEscore == "comunicacao" {
               escoreAjustado = escoreBase * 1.2
           } else {
               escoreAjustado = escoreBase
           }
       } else if tipoConhecimento == "Habilidade Prática" {
           if tipoEscore == "conceito" {
               escoreAjustado = escoreBase * 1.2
           } else {
               escoreAjustado = escoreBase
           }
       } else { // hibrido
           escoreAjustado = escoreBase
       }
       return escoreAjustado
   }
   
    func calculaEscoreConceito() -> String {
        
        // escore base como a média entre os valores de conceito e mental(organizacao)
        let escoreConceito : Float
        escoreConceito = (valorConceito + valorMental) / 2
        
        // escore modulado com base na idade
        var escoreConceitoMod : Float
        escoreConceitoMod = modulaEscoreIdade(tipoEscore: "conceito", escoreInicial: escoreConceito, crianca: crianca, adulto: adulto, idoso: idoso)
        
        // escore corrigido com base no tipo
        escoreConceitoMod = modulaEscoreTipo(tipoEscore: "conceito", escoreInicial: escoreConceitoMod)
        
        // arredonda, transforma o tipo e devolve o resultado
        let escoreConteitoInt : Int
        escoreConteitoInt = Int(round(escoreConceitoMod))
        
        return String(escoreConteitoInt)
        }
    
    func calculaEscoreComunicacao() -> String {
        
        // escore bse como a média entre os valores de verbal e mental(organizacao)
        let escoreComunicacao : Float
        escoreComunicacao = (valorVerbal + valorMental) / 2

        // escore modulado com base na idade
        var escoreComunicacaoMod : Float
        escoreComunicacaoMod = modulaEscoreIdade(tipoEscore: "comunicacao", escoreInicial: escoreComunicacao, crianca: crianca, adulto: adulto, idoso: idoso)
        
        // escore corrigido com base no tipo
        escoreComunicacaoMod = modulaEscoreTipo(tipoEscore: "comunicacao", escoreInicial: escoreComunicacaoMod)
        
        // arredonda, transforma e devolve o resultado
        let escoreComunicacaoInt : Int
        escoreComunicacaoInt = Int(round(escoreComunicacaoMod))
        
        return String(escoreComunicacaoInt)
    }

}


