echo "Executando postconfigure.sh"
$JBOSS_HOME/bin/jboss-cli.sh --properties=extensions.properties --file=extensions.cli
