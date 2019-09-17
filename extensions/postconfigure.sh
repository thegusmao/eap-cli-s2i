echo "Executando postconfigure.sh"
$JBOSS_HOME/bin/jboss-cli.sh --properties=$JBOSS_HOME/extensions/extensions.properties --file=$JBOSS_HOME/extensions/extensions.cli
