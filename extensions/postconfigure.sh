echo "Executando postconfigure.sh"

#source $JBOSS_HOME/extensions/extensions.properties
$JBOSS_HOME/bin/jboss-cli.sh --properties=$JBOSS_HOME/extensions/extensions.properties --file=$JBOSS_HOME/extensions/extensions.cli
