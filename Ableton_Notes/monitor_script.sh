#!/bin/bash
# Mude o diretório para a pasta que você deseja monitorar
DIRECTORY="/Users/lucasvictorino/Dropbox/LIVE PERFOMANCE : LIVE LOOPING/LIVE PROJECT 23:24/Live Perfomance 2024 Project"

# Variável para controlar se o Ableton já foi ativado
ableton_opened=false

# Monitora a pasta por eventos de abertura de arquivo
fswatch -o "$DIRECTORY" | while read; do
    # Verifica se existe algum arquivo .als sendo aberto
    for file in "$DIRECTORY"/*.als; do
        if [ -e "$file" ]; then
            # Evita que o script seja executado repetidamente ao detectar múltiplas mudanças
            if [ "$ableton_opened" = false ]; then
                echo "Arquivo .als detectado: $file"
                # Executa o AppleScript uma única vez
                osascript "/Users/lucasvictorino/Desktop/AbrirAbletonENotas.scpt"
                
                # Define ableton_opened como true
                ableton_opened=true
                
                # Pausa a execução por um tempo para evitar repetição imediata
                sleep 5  # Aguarde 5 segundos para evitar repetição
            fi
        fi
    done
    
    # Reseta a variável após um intervalo
    sleep 1  # Aguarda um segundo antes de verificar novamente
    ableton_opened=false
done


