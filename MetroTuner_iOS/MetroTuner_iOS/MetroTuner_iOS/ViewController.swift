//
//  ViewController.swift
//  MetroTuner_iOS
//
//  Created by Lucas Victorino on 05/11/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {


    @IBOutlet weak var beatLabel: UILabel!
   
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tedst: UILabel!
    
    
    
    @IBAction func starttopTapped(_ sender: UIButton) {
        // Verifica o título atual do botão para definir o comportamento
        if sender.title(for: .normal) == "Parar" {
            stopMetronome()
            sender.setTitle("Reiniciar", for: .normal) // Muda o título para "Reiniciar" quando o metrônomo é parado
        } else {
            startMetronome()
            sender.setTitle("Parar", for: .normal) // Muda o título para "Parar" quando o metrônomo é iniciado
        }
    }
    
  
    @IBAction func bpmChanged(_ sender: UISlider) {
        // Atualiza o valor de bpm com o valor do slider
        bpm = Double(sender.value)
        
        // Atualiza o texto do bpmLabel
        bpmLabel.text = "\(Int(bpm)) BPM"
        
        /*Reinicia o metrônomo se ele estiver em execução
        if isMetronomeRunning {
            stopMetronome()
            startMetronome()
        } */
    }
    
    // Função para reiniciar o metrônomo quando o ajuste é finalizado
    @IBAction func sliderAdjustmentFinished(_ sender: UISlider) {
        if isMetronomeRunning {
            stopMetronome()
            button.setTitle("Reiniciar", for: .normal)
            
        }
    }
    
    var metronomeTimer: Timer?
    var isMetronomeRunning = false
    var bpm: Double = 60.0
    var player: AVAudioPlayer?
    
    
  

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "MetroTuner"
        bpmLabel.text = "\(Int(bpm)) BPM"
        beatLabel.text = "MetroTuner"
        bpmSlider.value = Float(bpm)
        button.setTitle("Start", for: .normal)

    
    }
    
    
    func startMetronome() {
        isMetronomeRunning = true
        let interval = 60.0 / bpm
        metronomeTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(playBeat), userInfo: nil, repeats: true)
        metronomeTimer?.fire()
    }

    func stopMetronome() {
        isMetronomeRunning = false
        metronomeTimer?.invalidate()
        metronomeTimer = nil
    }

    @objc func playBeat() {
        // Você pode adicionar uma animação ou mudar a cor do label para indicar o beat
        playSound()
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "click", withExtension: "wav") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Erro ao reproduzir o som.")
        }
    }
}
