# Executando comandos .cli do EAP no OpenShift.

POC de EAP no OpenShift para executar comandos no cli customizar o xml.

### Estrutura

A estrutura do projeto é a seguinte:

- `.s2i`: Pasta contendo o script de assemble para executar copiar os arquivos customização do standalone no EAP.
- `extensions`:
  - `extensions.cli`: comandos cli para customização do EAP
  - `extensions.properties`: variáveis para serem utilizadas na customização 


### Alterando configurações do EAP via Extensions

A imagem do EAP permite que seja executa scripts shell durante o ciclo de vida da imagem. Dois desses scripts são o `preconfigure.sh` e o `postconfigure.sh`, um executa antes do standalone do EAP ser configurado (jgroups, ha, datasources, keycloak, security-domains, etc...) e o outro após essas configurações.

Para customizar o `standalone-openshift.xml` deve ser criado o `postconfigure.sh` no diretório `${JBOSS_HOME}/extensions` com permissão 774. Nesse script podemos utilizar o `jboss-cli.sh` para fazer alterações no `standalone-openshift.xml`.

Para exemplo o `postconfigure.sh` ficará assim:

``` sh
echo "Executando postconfigure.sh"
$JBOSS_HOME/bin/jboss-cli.sh --properties=$JBOSS_HOME/extensions/extensions.properties --file=$JBOSS_HOME/extensions/extensions.cli
```

Onde os arquivos `extensions.cli` contém os comandos cli e o `extensions.properties` contém variáveis de ambiente para serem utilizadas no `.cli`.

### Procedimento no OpenShift

Executar o comando

``` sh
oc create configmap extensions --from-file extensions/postconfigure.sh --from-file extensions/extensions.cli --from-file extensions/postconfigure.sh
```

Adicionar o ConfigMap como volume no Deployment

``` sh
oc set volume dc/<DEPLOYMENT> --add -m <JBOSS_HOME>/extensions --type configmap --configmap-name extensions --name extensions
```

Alterar as permissões do mount do configmap para 774

``` sh
oc patch dc/<DEPLOYMENT> -p '{ "spec": { "template": { "spec": { "volumes": [{ "configMap": { "defaultMode": 0774, "name": "extensions" }, "name": "extensions" }]}}}}'
```
