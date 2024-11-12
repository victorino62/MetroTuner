import os
import re

# Caminho da pasta mor
pasta_mor = '/Users/lucasvictorino/Dropbox/DropBox Sync/_Soundthinkers/Export Soundthinkers/2024 ST/SOUNDTRACK BINAURAL/TRACKS/LOOPS 10min'

# Função para montar o novo nome do arquivo com base na subpasta e no nome do arquivo original
def montar_novo_nome(subpasta, nome_arquivo):
    # Usa regex para encontrar a parte "Track X" no nome do arquivo
    match = re.search(r'Track\s*\d+', nome_arquivo, re.IGNORECASE)
    if match:
        parte_track = match.group(0).replace(" ", "")  # Remove espaços para obter "TrackX"
    else:
        print(f"Aviso: '{nome_arquivo}' não contém 'Track X', usando 'Track1' como padrão.")
        parte_track = "Track1"
    
    # Monta o novo nome no formato desejado: Subpasta_TrackX_loop.mp3
    novo_nome = f"{subpasta}_{parte_track}_loop.mp3"
    return novo_nome

# Percorre todas as subpastas e arquivos
for subpasta in os.listdir(pasta_mor):
    subpasta_caminho = os.path.join(pasta_mor, subpasta)
    
    if os.path.isdir(subpasta_caminho):
        for arquivo in os.listdir(subpasta_caminho):
            if arquivo.endswith('.mp3'):
                # Monta o novo nome do arquivo
                novo_nome = montar_novo_nome(subpasta, arquivo)
                caminho_antigo = os.path.join(subpasta_caminho, arquivo)
                caminho_novo = os.path.join(subpasta_caminho, novo_nome)
                
                # Renomeia o arquivo
                os.rename(caminho_antigo, caminho_novo)
                print(f"Arquivo '{arquivo}' renomeado para '{novo_nome}'")
