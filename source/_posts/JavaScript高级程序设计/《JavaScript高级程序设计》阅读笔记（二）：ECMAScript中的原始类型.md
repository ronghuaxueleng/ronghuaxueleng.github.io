---
title: 《JavaScript高级程序设计》阅读笔记（二）：ECMAScript中的原始类型
category: 《JavaScript高级程序设计》阅读笔记
tags: javascript
toc: true
abbrlink: bcee9cbd
date: 2016-08-02 00:00:00
modifiedOn: 2016-08-02 00:00:00
---

----------

#### 原始类型
```text
ECMAScript有5种原始类型(primitive type)，即Undefined、Null、Boolean、Number和String。ECMAScript提供了typeof来判断值的类型。
```
##### typeof运算符

```
var sTemp="test string";
alert(typeof sTemp);//outpus "string"
alert(typeof 95);//outpus "number"
```
```text
typeof运算符返回值只有5种，分别为：如果变量是Undefined型返回"undefined"，如果变量是Boolean型返回"boolean"，如果变量是Number型返回"number"，如果变量是String型返回"string"，如果变量是一种引用类型或Null类型返回"object"。
```
##### Undefined类型
```text
Undefined类型只有一个值，即undefined。当声明的变量未初始化和函数无明确的返回值时该变量的默认值和函数的返回值都是undefined。需要注意的是值undefined并不同于未定义的值，但typeof不区分这两种值。参考下面的代码：
```
```
var oTemp;
alert(typeof oTemp); //outpus "undefined"
alert(typeof otemp2); //outpus "undefined"
alert(oTemp==undefined); //outpus "true"
alert(oTemp2==undefined); //causes error
function testFunc(){
}
alert(testFunc() == undefined); //outpus "true"
```

##### Null类型
```text
Null也是只有一个值的类型，它只有一个专用值null。值undefined实际不是从值null派生来的，因此ECMAScript把它们定义为相等。
```
```
alert(null == undefined); //outpus "true"
```
```text
尽管这两个值相等，但它们的含义不同。undefined是声明了变量但未对其初始化时的值，null则用于表示尚未存在的对象。
```
##### Boolean类型
```text
Boolean有两个值true和false
```

##### Number类型
```text
Number可以表示32位整数，还可以表示64位浮点数，不同进制间的表示：
```

```
var iNum=55;// 10进制
var iNum=070;// 8进制var iNum=oxAB;//16进制
var fNum=3.125e7;//科学计数法表示浮点数
```
```text
几个特殊值也被定义为Number类型，前两个是Number.MAX_VALUE和Number.MIN_VALUE，它们定义了Number值集合的外边界。所有ECMAScript数都必须在这两个值之间，不过计算生成的数值结果可以不落在这两个数之间。

当计算生成的数大于Number.MAX_VALUE时，它将被赋予值Number.POSITIVE_INFINITY，意味着不再有数字值。同样，生成的数值小于Number.MIN_VALUE的计算也会被赋予值Number.NEGATIVE_INFINITY，也意味着不再有数字值。如果计算返回的结果是无穷大，那么生成的结果不能再用于其他计算。

事实上，有专门的值表示无穷大，即Infinity。Number.POSITIVE_INFINITY的值为Infinity，Number.NEGATIVE_INFINITY的值为-Infinity。

```
可以对任何数调用isFinit()方法来判断是不是无穷大。例：

```

var iResult = iNum*some_really_large_number;
if(isFinit(iResult)){ 
    alert("Number is finite");
}else{ 
    alert("Number is infinite");
}

```

还有一个特殊值是NaN，表示非数(Not a Number)。NaN一般为类型转换失败时的值，NaN不能用于算术计算，NaN的另一个奇特之处在于它与自身并不相等，因此推荐使用isNaN()，如：

```
alert(NaN == NaN); //outpus "false"
alert(isNaN("blue")); //outpus "true"
alert(isNaN("123")); //outpus "false"
alert(isNaN(123)); //outpus "false"
```
#### String类型
```text
String是唯一没有固定大小的原始类型。ECMAScript的字符字面量：

字面量　　　　　　　　含义
\n　　　　　　　　     换行
\t　　　　　　　　     制表符
\b　　　　　　　　　  空格
\r　　　　　　　　　　回车
\f　　　　　　　　　　换页符
\\　　　　　　　　　　反斜杠
\'　　　　　　　　　　单引号
\"　　　　　　　　　　双引号
\0nnn　　　　　　　  八进制代码nnn表示的字符
\xnn　　　　　　　　 16进制代码nn表示的字符
\unnnn　　　　　　   16进制的代码nnnn表不的Unicode字符
```
