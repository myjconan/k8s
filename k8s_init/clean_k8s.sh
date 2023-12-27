#! /bin/bash
error_codes=("Evicted" "Error" "ContainerStatusUnknown")
for error_code in ${error_codes[*]}; do
    echo $error_code
    nss=($(kubectl get pod -A | grep $error_code | awk 'NR>0 {print $1}' | tr "\n" " "))
    pods=($(kubectl get pod -A | grep $error_code | awk 'NR>0 {print $2}' | tr "\n" " "))
    for i in "${!nss[@]}"; do
        kubectl delete pod -n ${nss[i]} ${pods[i]}
    done
done
