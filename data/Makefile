all:	data_3 data_6

data_3:
	bash data_3.sh > data_3.out

data_4:	
	ruby data_4.rb > data_4.csv

data_5:
	echo "DATE,Precip,Empty" > data_5.out
	bash data_5.sh >> data_5.out
	sed -i -e 's/ /,/g' data_5.out

data_6: data_5 data_4
	csvfix join -f 1:1 data_4.csv data_5.out > data_6.csv

clean:
	rm data_*.out *.csv
