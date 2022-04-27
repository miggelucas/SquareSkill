//
//  ViewController.swift
//  SquareSkill
//
//  Created by Lucas Migge de Barros on 25/03/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let cardArray : [CardHelper] = [
        CardHelper(nome: "Bem vindo", index: 0, imagem: "Card Bem vindo"),
        CardHelper(nome: "competencias", index: 1, imagem: "Card compentências"),
        CardHelper(nome: "Conceito", index: 2, imagem: "Card Domínio"),
        CardHelper(nome: "Comunicacao", index: 3, imagem: "Card comunicação"),
        CardHelper(nome: "conhecimentos", index: 4, imagem: "Card conhecimentos"),
        CardHelper(nome: "Habilidade", index: 5, imagem: "Card habilidades"),
        CardHelper(nome: "teórico", index: 6, imagem: "Card Conhecimento teórico"),
        CardHelper(nome: "hibrido", index: 7, imagem: "Card híbrido")
        
    ]
    
    // protocolos do collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "minhaCelula", for: indexPath) as! cardHerlperCollectionViewCell
        let cardHelper = cardArray[indexPath.row]
        viewCell.cardImagem.image = UIImage(named: cardHelper.imagem)
        
        return viewCell
    }
    
    
    // protocolos do PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tiposDeConhecimento.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tiposDeConhecimento[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tipoConhecimentoTextfield.text = tiposDeConhecimento[row]
        tipoConhecimentoTextfield.resignFirstResponder()
    }
    
    @IBOutlet var collectionViewCards: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionViewCards.dataSource = self
        self.collectionViewCards.delegate = self
        
        self.tipoConhecimentoPickerView.dataSource = self
        self.tipoConhecimentoPickerView.delegate = self
        self.tipoConhecimentoTextfield.inputView = tipoConhecimentoPickerView
        
    }
    
    
    // conjunto de inputs do usuário
    
    @IBOutlet var viewInput: UIView!
    @IBOutlet var conhecimentoTextField: UITextField!
    @IBOutlet var sliderConceito: UISlider!
    @IBOutlet var sliderVerbal: UISlider!
    @IBOutlet var sliderMental: UISlider!
    @IBOutlet var switchCrianca: UISwitch!
    @IBOutlet var switchAdulto: UISwitch!
    @IBOutlet var switchIdoso: UISwitch!
    @IBOutlet var tipoConhecimentoTextfield: UITextField!
    var tipoConhecimentoPickerView = UIPickerView()
    
    let tiposDeConhecimento : [String] = ["Híbrido",
                                          "Conhecimento teórico",
                                          "Habilidade Prática"]
   
   
    // labels Card
    
    @IBOutlet var viewCard: UIView!
    @IBOutlet var conhecimentoLabel: UILabel!
    @IBOutlet var tipoConhecimento: UILabel!
    @IBOutlet var conceitoLabel: UILabel!
    @IBOutlet var comunicaçãoLabel: UILabel!
    
    @IBAction func botalCardHelper() {
        collectionViewCards.isHidden = !collectionViewCards.isHidden
    }
    
    @IBAction func novoInput() {
        // mostra view de entrada
        // limpa as entradas em caso de calcular novamente
        viewInput.isHidden = false
        conhecimentoTextField.text = ""
        sliderConceito.value = 1
        sliderVerbal.value = 1
        sliderMental.value = 1
        switchCrianca.isOn = false
        switchAdulto.isOn = false
        switchIdoso.isOn = false
    }
    
    @IBAction func botaoVoltar() {
        viewInput.isHidden = true
    }
    
    @IBAction func botaoDale() {
        let conhecimento : Conhecimento
        
        let tipoSelecionado = tipoConhecimentoTextfield.text ?? "Híbrido"
        
        conhecimento = Conhecimento(nome: conhecimentoTextField.text ?? "Conhecimento",
                                    conceito : sliderConceito.value, verbal : sliderVerbal.value,
                                    mental : sliderMental.value, crianca : switchCrianca.isOn,
                                    adulto : switchAdulto.isOn, idoso : switchIdoso.isOn,
                                    tipoConhecimento : tipoSelecionado)
        
    
        conhecimentoLabel.text = conhecimento.nome
        tipoConhecimento.text = tipoSelecionado
        conceitoLabel.text = conhecimento.calculaEscoreConceito()
        comunicaçãoLabel.text = conhecimento.calculaEscoreComunicacao()
        escondeComponentes()
    }
    
    func escondeComponentes() {
        viewInput.isHidden = true
        viewCard.isHidden = false
    }
}


