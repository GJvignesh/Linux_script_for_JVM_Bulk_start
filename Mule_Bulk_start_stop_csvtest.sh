lifecycle=$1
action=$2

#for now we will test in non-prod and see the result

ls -ltr /opt/infra/apm-local/${lifecycle}/apps > /opt/infra/apm-local/${lifecycle}/abc.csv

my_array1=( $(awk '{print $3}' /opt/infra/apm-local/${lifecycle}/abc.csv) )
my_array2=( $(awk '{print $9}' /opt/infra/apm-local/${lifecycle}/abc.csv) )
arraylength1=${#my_array1[@]}
arraylength2=${#my_array2[@]}

#For loop being used to see the commands that will be running

for ((i=1,j=1; i<${arraylength1}+1,j<${arraylength2}+1; i++,j++));
do
	sudo -u ${my_array1[$i-1]} /opt/infra/apm-shared/scripts/mule_start_stop.sh ${action} ${my_array2[$j-1]} ${lifecycle}
done


