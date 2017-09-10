
#=== FUNCTION ================================================================
# NAME: updateStack
# DESCRIPTION: Tags the AMI
# PARAMETER 1: ami
# PARAMETER 2: tagpair
# PARAMETER 3: region
#===============================================================================
function tagAMI {
   echo "Tagging AMI: $1 with $2"
   aws --region $3 ec2 create-tags \
      --resources $1 \
      --tags $2
   # TODO add error checking.
}

#=== FUNCTION ================================================================
# NAME: printHelp
# DESCRIPTION: Displays the usage of the script.
#=============================================================================
function printHelp {
   echo "Please use the following parameters:"
   echo "-a: The ID of the AMI you want to add tags to"
   echo "-t: The list of tagpairs you want added: Key=string,Value=string"
   echo "-r: The AWS region that the AMI is in (defaults to us-east-1)"
   exit 1
}



#=== FUNCTION ================================================================
# NAME: main
# DESCRIPTION: Main function of the script.
# PARAMETER 1: stack name
# PARAMETER 2: tags
# PARAMETER 3: region
#===============================================================================
function main {
   AMI_ID=
   TAGS=
   REGION="us-east-1"
   while getopts ":a:t:r:h" OPT; do
      case $OPT in
         a )
            AMI_ID=${OPTARG}
            echo "AMI ID: $AMI_ID"
            ;;
         t )
            TAGS=${OPTARG}
            echo "Tags: $TAGS"
            ;;
         r )
            REGION=${OPTARG}
            echo "Setting region to: $REGION"
            ;;
         h )
            exit
            help
            ;;
      esac
   done
   shift $((OPTIND-1))
   if [[ -z $AMI_ID ]] || [[ -z $TAGS ]]
   then
      printHelp
      exit 1
   fi
   tagAMI $AMI_ID "$TAGS" $REGION
}

main "$@"
