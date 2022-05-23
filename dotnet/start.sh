#!/bin/bash
func_ts()
{
str_a=$2
num_c=$[`tput cols`-${#str_a} -15]
str_b=`echo . $num_c | awk '{while(n++<$2)printf $1;print""}'`
if [ $1 -eq 0 ] ;then
echo -e "$str_a $str_b [\033[34m OK \033[0m]"
else
echo -e "\033[31m\033[05m$str_a $str_b [ error ]\033[0m"
fi
}

#func_ts 0 "this is ok!!"
#func_ts 1 "wasn : this is error!!"

app_path=/data/apps/webp
app_name=BitwinStatics
app_log_name=webp.log

cd ${app_path}
chmod 755 ${app_name}
num=`ps uax|grep "${app_path}/${app_name}" |grep -v grep |wc -l`
case $1 in
	start)
		if [ $num -eq 1 ];then
			func_ts 1 "this ${app_name} Processes already exist "
			exit 0
		else
			cd ${app_path}
			nohup ${app_path}/${app_name} >${app_path}/${app_log_name} 2>&1 &
			func_ts 0 "this ${app_name} Processes start success "
		fi
	;;
	stop)
		ps uax|grep "${app_path}/${app_name}" |grep -v grep |awk '{print $2}'|xargs kill -9
		if [ $? -eq 0 ];then
			func_ts 0 "this ${app_name} kill success"
		else
			func_ts 1 "this ${app_name} kill failed"
		fi
	;;
	status)
                if [ $num -eq 1 ];then
                        func_ts 1 "this ${app_name} Processes already exist "
                        exit 0
                else
                        func_ts 1 "this ${app_name} Processes is not exist "

                fi
                ;;
        *)
                echo "Please sh $0 'start|stop|status'"
esac
