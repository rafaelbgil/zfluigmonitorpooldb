#!/bin/bash
#Monitoramento Pool Banco de Dados
#Autor: Rafael Benites Gil

JBOSS_CLI="/app/fluig/jboss/bin/jboss-cli.sh"
IP_JBOSS="172.16.102.224"
PORTA_JBOSS="9999"
JAVA_HOME="/app/fluig/jdk-64/"
PATH=$JAVA_HOME/bin:$PATH
export PATH JAVA_HOME
case $1 in	
		-f)
			DATASOURCE="FluigDS"
		;;
		-r)
			DATASOURCE="FluigDSRO"
		;;		
		
		*)
				echo "+================================================================================+";
                echo "#Script Monitoramento Pool de Banco de dados Fluig                               #";
                echo "+================================================================================+";
                echo "________________________________________________________________________________"
                echo "# OPCOES:                                                                      #";
                echo "--------------------------------------------------------------------------------"
                echo "| -f : Exibe status do pool FluigDS                                            |"
                echo "| -r : Exibe status da pool FluigDSRO                                          |"
				echo "+==============================================================================+"
			exit;
		;;
esac
		
retorno=$(sh $JBOSS_CLI --connect --controller=$IP_JBOSS:$PORTA_JBOSS --commands="/subsystem=datasources/data-source=$DATASOURCE:read-resource(recursive=true,include-runtime=true)" | grep ActiveCount | grep -o "[0-9]*")
#echo "Fila: $fila , Mensagens: $retorno"
echo $retorno
