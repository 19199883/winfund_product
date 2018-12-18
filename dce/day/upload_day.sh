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
	# 910097
	echo "------------winfund: proc 910097---------------"
	ssh -p 44153							u910019@101.231.3.117 'rm /home/u910019/winfund/day097/x-dce/*day.so'
	scp -P 44153 ./lib/packaged/*.so		u910019@101.231.3.117:/home/u910019/winfund/day097/x-dce/
	scp -P 44153 ./ev/*.txt					u910019@101.231.3.117:/home/u910019/winfund/day097/x-dce/
	scp -P 44153 ./ev/*.txt					u910019@101.231.3.117:/home/u910019/winfund/day097/x-dce/tools/
	scp -P 44153 ./97/*.csv					u910019@101.231.3.117:/home/u910019/winfund/day097/x-dce/
	scp -P 44153 ./97/*.csv					u910019@101.231.3.117:/home/u910019/winfund/day097/x-dce/tools/
	ssh -p 44153							u910019@101.231.3.117 'rm /home/u910019/winfund/day097/x-dce/tools/*.log'
	ssh -p 44153							u910019@101.231.3.117 '/home/u910019/winfund/day097/x-dce/tools/configurator.py'
	scp -P 44153							u910019@101.231.3.117:/home/u910019/winfund/day097/x-dce/tools/configurator.log ./
	cat ./configurator.log
	echo "--------------winfund: end proc 910097---------"
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
