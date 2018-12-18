#!/bin/bash
DAY_NIGHT=day

function encrypt_so
{
	rm ./lib/packaged/*.so
	for cur_so in `ls  ./lib/bare/`
	do
		echo "process ${cur_so}"
		tar -czvf - -C ./lib/bare ${cur_so} | openssl des3 -salt -k 617999 -out ./lib/packaged/${cur_so}  
	done

}


function upload_files
{

#########################
# winfund
###################
	# 910229
	echo "-------------winfund:begin proc 910229--------------"
	ssh -p 44163						u910019@101.231.3.117 'rm /home/u910019/winfund/day229/x-shfe/*day.so'
	scp -P 44163 ./lib/packaged/*.so	u910019@101.231.3.117:/home/u910019/winfund/day229/x-shfe/
	scp -P 44163 ./ev/*.txt	u910019@101.231.3.117:/home/u910019/winfund/day229/x-shfe/
	scp -P 44163 ./ev/*.txt	u910019@101.231.3.117:/home/u910019/winfund/day229/x-shfe/tools/
	scp -P 44163 ./229/*.csv			u910019@101.231.3.117:/home/u910019/winfund/day229/x-shfe/
	scp -P 44163 ./229/*.csv			u910019@101.231.3.117:/home/u910019/winfund/day229/x-shfe/tools/
	ssh -p 44163						u910019@101.231.3.117 'rm /home/u910019/winfund/day229/x-shfe/tools/*.log'
	ssh -p 44163						u910019@101.231.3.117 '/home/u910019/winfund/day229/x-shfe/tools/configurator.py'
	scp -P 44163						u910019@101.231.3.117:/home/u910019/winfund/day229/x-shfe/tools/configurator.log ./
	cat ./configurator.log
	echo "-------------winfund:end proc 910229--------------"

	# 910101
	echo "-------------winfund:begin proc 910101--------------"
	ssh -p 44163						u910019@101.231.3.117 'rm /home/u910019/winfund/day101/x-shfe/*day.so'
	scp -P 44163 ./lib/packaged/*.so	    u910019@101.231.3.117:/home/u910019/winfund/day101/x-shfe/
	scp -P 44163 ./ev/*.txt	                u910019@101.231.3.117:/home/u910019/winfund/day101/x-shfe/
	scp -P 44163 ./ev/*.txt	                u910019@101.231.3.117:/home/u910019/winfund/day101/x-shfe/tools/
	scp -P 44163 ./101/*.csv			    u910019@101.231.3.117:/home/u910019/winfund/day101/x-shfe/
	scp -P 44163 ./101/*.csv			    u910019@101.231.3.117:/home/u910019/winfund/day101/x-shfe/tools/
	ssh -p 44163						u910019@101.231.3.117 'rm /home/u910019/winfund/day101/x-shfe/tools/*.log'
	ssh -p 44163						   u910019@101.231.3.117 '/home/u910019/winfund/day101/x-shfe/tools/configurator.py'
	scp -P 44163						    u910019@101.231.3.117:/home/u910019/winfund/day101/x-shfe/tools/configurator.log ./
	cat ./configurator.log
	echo "-------------winfund:end proc 910101--------------"
}

###################
# enter working directory
###########################
function  enter_wd
{
	 this_dir=`pwd`
	 dirname $0|grep "^/" >/dev/null
	 if [ $? -eq 0 ];then
			 this_dir=`dirname $0`
	 else
			 dirname $0|grep "^\." >/dev/null
			 retval=$?
			 if [ $retval -eq 0 ];then
					 this_dir=`dirname $0|sed "s#^.#$this_dir#"`
			 else
					 this_dir=`dirname $0|sed "s#^#$this_dir/#"`
			 fi
	 fi

	cd $this_dir
}

enter_wd
encrypt_so
upload_files
