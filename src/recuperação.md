# Roteiro para recuperação completa do ambiente 

# Recuperação via portainer + GitLab CI/CD

- Criar no gitlab o projeto itgs/wiki e itgs/wiki:sshd com os arquivos abaixo
Dockerfile-ssh
Dockerfile-wiki:main

- Verificar se o build foi com sucesso dockerhub.itgs.org.br

- Criar o stack no portainer com o arquivo stack.yaml ( configurar as senhas )

- Fazer a instalação padrão da wiki

- recuperar o backup e o arquivo LocalSettings.php

# Recuperação via docker

- criar as imagens
Dockerfile-ssh
Dockerfile-wiki:main

- Adapitar stack.yaml para docker

- Verificar como vai fazer o proxy reverso e o ssl

- Instalar a wiki

- Recuperar o backup e o arquivo LocalSettings.php


