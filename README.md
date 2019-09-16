# Executando comandos .cli do EAP com s2i.

POC de EAP no OpenShift para executar comandos no cli customizar o xml.

### Estrutura

A estrutura do projeto é a seguinte:

- `.s2i`: Pasta contendo o script de assemble para executar os comandos de customização do standalone no EAP.
- `configuration`:
  - `extensions.cli`: comandos cli para customização do EAP
  - `extensions.properties`: variáveis para serem utilizadas na customização 