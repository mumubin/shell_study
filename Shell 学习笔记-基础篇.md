# Shell 学习笔记-基础篇

## 学习教程

[LearnShell](https://www.learnshell.org/)

## 学习内容

### Hello,World

#### 知识点

- shell 文件开头

```bash
  #!/bin/bash
```

- 查看所有在运行的 bash 程序

```bash
  ps | grep $$
```

- 查看 bash 解释器

```bash
   which bash
```

- 输出 Hello,world

```bash
#!/bin/bash
echo "Hello,world!"
```

### 变量

- 定义变量:用等号=(不能有空白)

```bash
PRICE_PER_APPLE=5
MyFirstLetters=ABC
greeting='Hello        world!'
```

- 转义字符:用反斜杠\

```bash
PRICE_PER_APPLE=5
echo "The price of an Apple today is: \$HK $PRICE_PER_APPLE"
```

- 防止混淆.${}引用变量

```bash
MyFirstLetters=ABC
echo "The first 10 letters in the alphabet are: ${MyFirstLetters}DEFGHIJ"
```

- 多个空白字符用,""引用

```bash
greeting='Hello        world!'
echo $greeting" now with spaces: $greeting"
```

- 命令的输出作为变量的值,``引用

```bash
greeting='Hello        world!'
echo $greeting" now with spaces: $greeting"
```

- 时间变量

```bash
FileWithTimeStamp=/tmp/my-dir/file_$(/bin/date +%Y-%m-%d).txt
echo $FileWithTimeStamp
```

- 练习

```bash
BIRTHDATE="Jan 1, 2000"
Presents=10
BIRTHDAY=`date -d "$date1" +%A`

if [ "$BIRTHDATE" == "Jan 1, 2000" ] ; then
    echo "BIRTHDATE is correct, it is $BIRTHDATE"
else
    echo "BIRTHDATE is incorrect - please retry"
fi
if [ $Presents == 10 ] ; then
    echo "I have received $Presents presents"
else
    echo "Presents is incorrect - please retry"
fi
    echo "I was born on a $BIRTHDAY"
```

> BIRTHDAY 这个变量在 macos 下无法得到值，在 centos 下运行正常

### 向脚本传递变量

- 脚本执行后跟参数$1 开始
- $0 代表脚本本身
- $# 参数个数

```bash
#!/bin/bash
echo $3
BIG=$5
echo "A $BIG costs just $6"
echo $#
```

```bash
sh my_shopping.sh apple 5 banana 8 "Fruit Basket" 15
```

### 数组

- ()包含
- 空格间隔
- 无需每个都初始化
- 数组的长度${#arrayname[@]}
- 读某元素${arrayname[3]}

```bash
my_array=(apple banana "Fruit Basket" orange)
new_array[2]=apricot
echo  ${#my_array[@]}                   # 4
my_array[4]="carrot"                    # value assignment without a $ and curly brackets
${my_array[3]}    #read element of array
```

### 数学运算符

```bash
$((expression))
```

### 字符串操作

- 字符串长度

```bash
STRING="this is a string"
echo ${#STRING}
```

- index

```bash
STRING="this is a string"
SUBSTRING="hat"
expr index "$STRING" "$SUBSTRING"
```


> 此命令在 mac 上  不支持，centos 可以

- 截取子字符串

```bash
STRING="this is a string"
POS=1
LEN=3
echo ${STRING:$POS:$LEN}   #如果没有$LEN,则截断致字符串末尾
```

> 此命令在 mac 上  不支持，centos 可以

- 字符串替换

```bash
AA="to be or not to be"             #[@]不是必须
echo ${AA[@]/be/eat}                     #匹配第一个
echo ${AA[@]//"to be"/}                 #匹配所有
echo ${AA[@]/#to be/eat now}   #匹配以to be开头
echo ${AA[@]/%be/eat}        # 匹配以be结尾
echo ${AA[@]/%be/be on $(date +%Y-%m-%d)} #替换结尾用函数
```

### 判断语句

- if [ expression ]; then

  - 空字符串(包括多个空格)，undefined 为 false
  - ! 取反
  - &&代表与，||代表或 -条件表达式需用双括号引用 [[ ]]

```bash
NAME="CC"

if [ "$NAME" = "AA" ]; then
    echo "I'm AA"
elif [ "$NAME" = "CC" ]; then
    echo "I'm CC"
else
    echo "I'm BB"
fi
```

- case 语句

```bash
case "$variable" in
    "$condition1" )
        command...
    ;;
    "$condition2" )
        command...
    ;;
esac

mycase=1
case $mycase in
    1) echo "You selected bash";;
    2) echo "You selected perl";;
    3) echo "You selected phyton";;
    4) echo "You selected c++";;
    5) exit
esac
```

### 循环语句

- for 循环

```bash
#!/bin/bash

array=(1 4 9 16 25)

for arg in ${array[@]}
do
echo $arg
done
```

- while 循环
```bash
# basic construct
while [ condition ]
do
 command(s)...
done


COUNT=4
while [ $COUNT -gt 0 ]; do
  echo "Value of count is: $COUNT"
  COUNT=$(($COUNT - 1))
done
```

- until 语句

```bash
# basic construct
until [ condition ]
do
 command(s)...
done

COUNT=1
until [ $COUNT -gt 5 ]; do
  echo "Value of count is: $COUNT"
  COUNT=$(($COUNT + 1))
done
```

### 函数

```bash
function_name {
  command...
}
```

```bash
function function_B {
  echo "Function B."
}
function function_A {
  echo "$1"
}
function adder {
  echo "$(($1 + $2))"
}

# FUNCTION CALLS
# Pass parameter to function A
function_A "Function A."     # Function A.
function_B                   # Function B.
# Pass two parameters to function adder
adder 12 56  
```