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

	# zhongxin 102851703 苏艳辉
	echo "-------------winfund:zhongxin 102851703 苏艳辉--------------"
	scp -Cp -P	22 			u910019@123.207.33.52:/home/u910019/tick-data/mc/medi-shfe-subcribed-mc.csv ./

	ssh -p		22						u910019@172.31.113.80 'rm /home/u910019/winfund/day703/x-shfe/*day.so'
	ssh -p		22						u910019@172.31.113.80 'rm /home/u910019/winfund/day703/x-shfe/st*.txt'
	ssh -p		22						u910019@172.31.113.80 'rm /home/u910019/winfund/day703/x-shfe/tools/st*.txt'
	scp -Cp -P	22 ./medi-shfe-subcribed-mc.csv	u910019@172.31.113.80:/home/u910019/domi_contr_check/cur_domi_contrs.txt
	scp -Cp -P	22 ./lib/packaged/*.so	u910019@172.31.113.80:/home/u910019/winfund/day703/x-shfe/
	scp -Cp -P	22 ./ev/*.txt	        u910019@172.31.113.80:/home/u910019/winfund/day703/x-shfe/
	scp -Cp -P	22 ./ev/*.txt	        u910019@172.31.113.80:/home/u910019/winfund/day703/x-shfe/tools/
	scp -Cp -P	22 ./703/*.csv			u910019@172.31.113.80:/home/u910019/winfund/day703/x-shfe/
	scp -Cp -P	22 ./703/*.csv			u910019@172.31.113.80:/home/u910019/winfund/day703/x-shfe/tools/
	ssh -C -p	22						u910019@172.31.113.80 'rm /home/u910019/winfund/day703/x-shfe/tools/*.log'
	ssh -C -p	22						u910019@172.31.113.80    '/home/u910019/winfund/day703/x-shfe/tools/configurator.py'
	scp -Cp -P	22						u910019@172.31.113.80:/home/u910019/winfund/day703/x-shfe/tools/configurator.log ./
	cat ./configurator.log
	echo "-------------zhongxin 102851703 苏艳辉--------------"
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
