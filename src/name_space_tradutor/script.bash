#!/bin/bash

# Resumo da edição que aparecerá no histórico das páginas
EDIT_SUMMARY="Atualizando prefixos 'osmc:' para 'afac:' em links e predefinições (execução em massa)."

echo "Iniciando processo de atualização em massa de páginas..."
echo "Resumo da edição: '$EDIT_SUMMARY'"

# --- Obter lista de TODAS as páginas do arquivo gerado pelo SQL ---
# Certifique-se de que o caminho para pages_to_process.txt está correto
# rodar lista.bash
PAGES_LIST=$(cat ~/pages_to_process.txt)

if [ -z "$PAGES_LIST" ]; then
    echo "AVISO: O arquivo de lista de páginas está vazio ou não existe. Verifique o caminho e a geração do arquivo SQL."
    exit 0
fi

echo "Processando $(echo "$PAGES_LIST" | wc -l) páginas..."

# --- Loop sobre cada página na lista ---
# `IFS=$'\n'` é crucial para que o loop processe cada linha como uma página individual
# e não divida títulos com espaços.
IFS=$'\n'
for PAGE_TITLE in $PAGES_LIST; do
    if [ -z "$PAGE_TITLE" ]; then
        continue # Pula linhas vazias
    fi

    echo -e "\n--- Processando página: '$PAGE_TITLE' ---"

    # 1. Obter o conteúdo atual da página
    PAGE_CONTENT=$(php ./run.php getText.php "$PAGE_TITLE")

    if [ -z "$PAGE_CONTENT" ]; then
        echo "ATENÇÃO: Não foi possível obter o conteúdo da página '$PAGE_TITLE'. Pulando."
        continue # Pula para a próxima página se não conseguir obter o conteúdo
    fi

    # Variável para rastrear se houve alguma alteração nesta página
    CHANGES_MADE=0
    ORIGINAL_CONTENT="$PAGE_CONTENT" # Salva o conteúdo original para comparação

    # 2. Realizar as substituições com sed
    # Substituição 1: [[osmc: para [[afac:
    PAGE_CONTENT=$(echo "$PAGE_CONTENT" | sed -E 's#\[\[osmc:#[[afac:#g')
    PAGE_CONTENT=$(echo "$PAGE_CONTENT" | sed -E 's#\|osmc:#|afac:#g')

    # Substituição 2: {{ns-xref|osmc| para {{ns-xref|afac|
    PAGE_CONTENT=$(echo "$PAGE_CONTENT" | sed -E 's#\{\{ns-xref\|osmc\|#{{ns-xref|afac|#g')

    # Substituição 3: osmc: dentro do texto exibido de links [[...|osmc:...]]
    PAGE_CONTENT=$(echo "$PAGE_CONTENT" | sed -E 's#\|osmc:([^\]]+)\]\]#\|afac:\1\]\]#g')

    # 3. Verificar se houve alguma alteração antes de salvar
    if [ "$ORIGINAL_CONTENT" != "$PAGE_CONTENT" ]; then
        echo "Alterações detectadas para '$PAGE_TITLE'. Salvando..."
        CHANGES_MADE=1
        # 4. Salvar o novo conteúdo de volta na página
        echo "$PAGE_CONTENT" | php ./run.php edit.php \
            --summary "$EDIT_SUMMARY" \
            --bot \
            "$PAGE_TITLE"
    else
        echo "Nenhuma alteração necessária para '$PAGE_TITLE'. Pulando a gravação."
    fi

    # Pequena pausa para evitar sobrecarregar o servidor (opcional, ajuste conforme necessário)
    sleep 0.1

done # Fim do loop

echo -e "\nProcesso de atualização em massa concluído."

# Recomendação para limpar o cache geral após todas as edições
echo "Reconstruindo o cache geral do wiki para refletir as mudanças..."
php ./run.php rebuildall.php

echo "Script finalizado."
