# Roteiro para recuperação completa do ambiente 

- Estudar como foi implementado o portainer + GitLab CI/CD + dockerhub
- Verificar as possiveis senhas de banco, wiki, etc...
- Terique que verificar os arquivos e editar eles de acordo com o ambiente e as senhas
- os caminhos e urls são do ambiente atual, se precisar altere eles
- 

# Recuperação via portainer + GitLab CI/CD + dockerhub

- Criar no gitlab o projeto itgs/wiki e itgs/wiki:sshd com os arquivos abaixo
Dockerfile-ssh
Dockerfile-wiki:main

- Verificar se o build foi feito com sucesso. 

- Criar o stack no portainer com o arquivo stack.yaml ( configurar as senhas, caminhos e urls )

- Fazer a instalação padrão da wiki

- verificar acesso por ssh na porta configurada no yaml

- recuperar o backup e o arquivo LocalSettings.php

# Recuperação via docker

- criar as imagens
Dockerfile-ssh
Dockerfile-wiki:main

- Adapitar stack.yaml para docker

- Verificar como vai fazer o proxy reverso e o ssl

- Instalar a wiki

- Recuperar o backup e o arquivo LocalSettings.php


