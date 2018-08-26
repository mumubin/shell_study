# Shell 学习笔记-提高篇

## 学习教程

[LearnShell](https://www.learnshell.org/)

## 学习内容

### 特殊变量

- $0：当前脚本文件
- $n：传入脚本或者语法参数的第几个数
- $#：传入脚本或者语法参数的个数
- $@：所有传入脚本和  函数的参数
- $\*：所有传入脚本和  函数的参数
- $?： 上一条命令的执行状态码
- $$：当前 shell 的 process id
- $!： Shell 最后运行的后台 Process 的 PID

```bash
$@,$*在双引号引用下表现不一样,$*会变为一个整体
```

- ‘’：单引号，不具有变量置换的功能
- “”：双引号，具有变量置换的功能
- ()：在中间的为子 shell 的起始与结束
- {}：在中间为命令块的组合

### trap 命令

**trap**命令用于指定在接收到信号后将要采取的动作，常见的用途是在脚本程序被中断时完成清理工作。当 shell 接收到 sigspec 指定的信号时，arg 参数（命令）将会被读取，并被执行

- SIGINT 中断信号(Ctrl + C:2)
- SIGQUIT 退出信号(Ctrl +\\:2)
- [SIGFE](https://www.gnu.org/software/libc/manual/html_node/Termination-Signals.html)  算术错误

```bash
#!/bin/bash

# traptest.sh
# notice you cannot make Ctrl-C work in this shell,
# try with your local one, also remeber to chmod +x
# your local .sh file so you can execute it!

trap "echo Booh!" SIGINT SIGTERM
echo "it's going to run until you hit Ctrl+Z"
echo "hit Ctrl+C to be blown away!"

while true
do
    sleep 60
done
```

### 文件测试

- 测试文件是否存在

```bash
#!/bin/bash
filename="sample.md"
if [ -e "$filename" ]; then
    echo "$filename exists as a file"
fi
```

- 测试文件目录是否存在

```bash
#!/bin/bash
directory_name="test_directory"
if [ -d "$directory_name" ]; then
    echo "$directory_name exists as a directory"
fi
```

- 测试是否可读

```
#!/bin/bash
filename="sample.md"
if [ ! -f "$filename" ]; then
    touch "$filename"
fi
if [ -r "$filename" ]; then
    echo "you are allowed to read $filename"
else
    echo "you are not allowed to read $filename"
fi
```

### 命令行选项解析

#### [getopt](https://www.cnblogs.com/yxzfscg/p/5338775.html)

```bash
#!/bin/bash

while getopts "a:bc" arg
do
        case $arg in
             a)
                echo "a's arg:$OPTARG"
                ;;
             b)
                echo "b"
                ;;
             c)
                echo "c"
                ;;
             ?)  #当有不认识的选项的时候arg为?
            echo "unkonw argument"
        exit 1
        ;;
        esac
done
```

- 只支持短选项
- 选项后面的冒号表示该选项需要参数,且参数存在$OPTARG 中
- OPTIND:代表当前选项在参数列表中的位移
- shift $(($OPTIND - 1)) 取选项之后的参数

####[getopt](https://www.cnblogs.com/FrankTan/archive/2010/03/01/1634516.html)

```bash
#!/bin/bash
#-o表示短选项，两个冒号表示该选项有一个可选参数，可选参数必须紧贴选项
#如-carg 而不能是-c arg
#--long表示长选项
#"$@"在上面解释过
# -n:出错时的信息
# -- ：举一个例子比较好理解：
#我们要创建一个名字为 "-f"的目录你会怎么办？
# mkdir -f #不成功，因为-f会被mkdir当作选项来解析，这时就可以使用
# mkdir -- -f 这样-f就不会被作为选项。

TEMP=`getopt -o ab:c:: --long a-long,b-long:,c-long:: \
     -n 'example.bash' -- "$@"`

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
#set 会重新排列参数的顺序，也就是改变$1,$2...$n的值，这些值在getopt中重新排列过了
eval set -- "$TEMP"

#经过getopt的处理，下面处理具体选项。

while true ; do
        case "$1" in
                -a|--a-long) echo "Option a" ; shift ;;
                -b|--b-long) echo "Option b, argument \`$2'" ; shift 2 ;;
                -c|--c-long)
                        # c has an optional argument. As we are in quoted mode,
                        # an empty parameter will be generated if its optional
                        # argument is not found.
                        case "$2" in
                                "") echo "Option c, no argument"; shift 2 ;;
                                *)  echo "Option c, argument \`$2'" ; shift 2 ;;
                        esac ;;
                --) shift ; break ;;
                *) echo "Internal error!" ; exit 1 ;;
        esac
done
echo "Remaining arguments:"
for arg do
   echo '--> '"\`$arg'" ;
done
```

##### getops 命令的不足：

- 选项参数的格式必须是-d val，而不能是中间没有空格的-dval。
- 所有选项参数必须写在其它参数的前面，因为 getopts 是从命令行前面开始处理，遇到非-开头的参数，或者选项参数结束标记--就中止了，如果中间遇到非选项的命令行参数，后面的选项参数就都取不到了。
- 不支持长选项， 也就是--debug 之类的选项

### Process Substitution

- 输出  重定向 >

```bash
$ who > users.out
```

- 追加模式输出  重定向 >>

```bash
$ ls >> users.out
```

- 输入  重定向 <

```bash
$ wc -l < users.out
```

#### [深入重定向](http://www.runoob.com/linux/linux-shell-io-redirections.html)

一般情况下，每个 Unix/Linux 命令运行时都会打开三个文件：

- 标准输入文件(stdin)：stdin 的文件描述符为 0，Unix 程序默认从 stdin 读取数据。
- 标准输出文件(stdout)：stdout 的文件描述符为 1，Unix 程序默认向 stdout 输出数据。
- 标准错误文件(stderr)：stderr 的文件描述符为 2，Unix 程序会向 stderr 流中写入错误信息。

- 如果希望 stderr 重定向到 file，可以这样写

```bash
command 2 > file
```

- 如果希望将 stdout 和 stderr 合并后重定向到 file，可以这样写

```bash
command > file 2>&1
```

> 放在>后面的&，表示重定向的目标不是一个文件，而是一个文件描述符
> n >& m 将输出文件 m 和 n 合并。
> n <& m 将输入文件 m 和 n 合并

- 如果希望对 stdin 和 stdout 都重定向，可以这样写：

```bash
command < file1 >file2
```

- Here Document

```bash
 wc -l << EOF
heredoc> mmb
heredoc> learn
heredoc> note
heredoc> shell
heredoc> EOF
       4
```

-  禁止输出

```bash
ls > /dev/null
```

### [正则表达式](http://wiki.jikexueyuan.com/project/shell-learning/a-regular-expressinon-bre.html)

#### [BRE:基本正则表达式](http://man.linuxde.net/docs/shell_regex.html)

- 完全匹配 mumubin

```bash
grep -n mumubin *.sh
```

- mumubin 作为行的开头

```bash
grep -n ^mumubin *.sh
```

- mumubin 作为行的结尾

```bash
grep -n mumubin$ *.sh
```

- 这一行完全  为 mumubin,没有其它字符

```bash
grep -n ^mumubin$ *.sh
```

- 完全匹配 mumubin 或者 Mumubin

```bash
grep -n "[mM]umubin" *.sh
```

- 匹配 mumu 和 bin,中间是任意  一个字符

```bash
grep -n mumu.bin *.sh
```

- 匹配 mumu 和 bin,中间是任意 0 个活多个字符

```bash
grep -n "mumu.*bin" *.sh
```

```
^：匹配行首位置
$：匹配行尾位置
.：匹配任意祖父
*：对*之前的匹配整体或字符匹配任意次（包括 0 次）
?：对?之前的匹配整体或字符匹配 0 次或 1 次
{n}: 对n之前的匹配整体或字符匹配 n 次
{m,}: 对{ 之前的匹配整体或字符匹配至少 m 次
{m,n}: 对{ 之前的匹配整体或字符匹配 m 到 n 次
[abcdef]: 对单字符而言匹配[]中的字符
[a-z]： 对单字符而言，匹配任意一个小写字母
[^a-z]：不匹配括号中的内容
|：匹配左右两边任意一项
```
