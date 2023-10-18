# wiki-backup
_Backup_ dos dados e configurações da [Mediawiki](https://www.mediawiki.org) de documentação dos projetos ITGS, atualmente instalada em https://wiki.addressforall.org.

Os _backups_ são mantidos em código-fonte XML, de modo que o *git* oferece todos os recursos de controle de versões. As operações são realizadas com ***frequência no máximo mensal***, quando uma [versão XML otimizada](https://github.com/AddressForAll/wiki-backup/issues/2) é gravada. ***Anualmente***, para limpar o site dos conteúdos expúrios e atualizar mais livremente a versão do software, toda a Mediawiki é reinstalada através do XML e não do `pg_dump`.   

Para imagens ver https://stackoverflow.com/questions/1002258/exporting-and-importing-images-in-mediawiki/8771896

A função do _backup_ é também a ***preservaçã digital*** dentro das políticas [Digital-guard](https://git.digital-guard.org).
