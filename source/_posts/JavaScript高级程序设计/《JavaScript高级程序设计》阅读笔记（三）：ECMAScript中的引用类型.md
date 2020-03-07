---
title: 《JavaScript高级程序设计》阅读笔记（三）：ECMAScript中的引用类型
category: 《JavaScript高级程序设计》阅读笔记
tags: javascript
toc: true
abbrlink: b6bf4ab1
date: 2016-08-03 00:00:00
modifiedOn: 2016-08-03 00:00:00
---

----------

#### 引用类型
##### Object类

```text
ECMAScript中的所有类都是由Object类继承而来。

Object类具有下列属性：

Constructor：对创建对象的函数的引用（指针），对于Object类，该指针指向原始的Object()函数

Prototype：对该对象的对象原型的引用。

Object类还有几个方法：
    1、PropertyIsEnumerable(property)：判断给定的属性是否可以用for...in语句进行枚举

    2、ToString()：返回对象的原始字符串表示。

    3、ValueOf()：返回最适合该对象的原始值。对于许多类，该方法返回的值都与toString()的返回值相同。

上面列出的每种属性和方法都会被其他类覆盖。
```
<!-- more -->

##### Boolen类

在ECMAScript中很少使用Boolean对象，因为不易理解，如：

```
var oFalseObject = new Boolean(false);
var bResult= oFalseObject && true; //outpus true
```

在这段代码中，用false值创建Boolean对象，然后用这个值与原始值true进行 AND 操作。在Boolean运算中，false和true进行AND 操作的结果是 false。不过，在这行代码中，计算的是oFalseObject，而不是它的值false。在Boolean表达式中，所有对象都会被自动转换为true，所以结果为true。参考下面的代码：

```
var oFalseObject = new Boolean(false);
var bResult= oFalseObject && true; //outpus true
var bResult2= oFalseObject.valueOf() && true; //outpus false
```
##### Number类
```text
Number的toString()方法在上篇文章中有详细的介绍。

Number有几个处理数值的专用方法：

toFixed(参数)：返回的是具有指定位数小数的数字的字符串表示。参数范围为0—20

toExponential(参数)：返回的是用科学计数法表示的数字的字符串形式。与toFixed()方法相似，toExponential()也有一个参数要输出的小数的位数。参数范围为0—20

toPrecision(参数)：根据最有意义的形式来返回数字的预定形式或指数形式。它有一个参数，即用于表示数字总数（不包括指数）。参数最小为1
```
以上三个方法都会进行舍入操作。示例代码：

```
var oNumber=new Number(99);
console.log(oNumber.toFixed(0));    //outpus 99
console.log(oNumber.toFixed(2));    //outpus 99.00

var oNumber1=new Number(99);
console.log(oNumber1.toExponential(0));    //outpus 1e+2 进行了舍入操作
console.log(oNumber1.toExponential(1));    //outpus 9.9e+1
console.log(oNumber1.toExponential(2));    //outpus 9.90e+1

var oNumber3=new Number(99);
console.log(oNumber3.toPrecision(0));    //outpus error precision 0 out of range
console.log(oNumber3.toPrecision(1));    //outpus 1e+2 进行了舍入操作
console.log(oNumber3.toPrecision(2));    //outpus 99
console.log(oNumber3.toPrecision(3));    //outpus 99.0
```
##### String类
```text
String对象的valueOf()方法和toString()方法都会返回String型的原始值：
```
```
var oStringObject=new String("Hello world");
console.log(oStringObject.valueOf() == oStringObject.toString());//outpus true
```

String类具有length属性，它是字符串中的字符个数，双字节字符也算一个字符。

String类有大量的方法，主要介绍如下：

charAt(整型参数)：返回字符串中单个字符。示例：

```
var oStringObject=new String("Hello world");
console.log(oStringObject.charAt(0));//outpus "H"
console.log(oStringObject.charAt(1));//outpus "e"
console.log(oStringObject.charAt(11));//outpus (an empty string)
```

charCodeAt(整型参数)：返回字符串中单个字符代码。示例：

```
var oStringObject=new String("Hello world");
console.log(oStringObject.charCodeAt(0));//outpus "72"
console.log(oStringObject.charCodeAt(1));//outpus "101"
console.log(oStringObject.charCodeAt(11));//outpus NaN
```

concat(字符串)：把一个或多个字符串连接到String对象的原始值上。示例：

```
var oStringObject=new String("Hello world");
var sResult=oStringObject.concat(" Concat");
console.log(oStringObject);//outpus "String { 0="H", 1="e", 2="l", ...}"
console.log(sResult);//outpus "Hello world Concat"
alert(oStringObject);//outpus "Hello world"
```

indexOf(字符串)：返回指定的字符串在另一个字符串中的位置（从字符串的开头进行检索）。

lastIndexOf(字符串)：返回指定的字符串在另一个字符串中的位置（从字符串的结尾进行检索）。示例：

```
var oStringObject=new String("Hello Hello");
console.log(oStringObject.indexOf("lo"));//outpus 3
console.log(oStringObject.lastIndexOf("lo"));//outpus 9
```

localeCompare(字符串)：对字符串进行排序，返回值是下列三个之一：

A、如果String对象按照字母顺序排在参数中的字符串之前，返回负数(通常是-1，但真正返回值由具体实现决定)

B、如果String对象等于参数中的字符串，返回0

C、如果String对象按照字母顺序排在参数中的字符串之后，返回正数(通常是1，但真正返回值由具体实现决定)

示例：

```
var oStringObject=new String("Hello");
console.log(oStringObject.localeCompare("aello"));    //outpus 1
console.log(oStringObject.localeCompare("Hello"));    //outpus 0
console.log(oStringObject.localeCompare("zello"));    //outpus -1
```

slice(整型参数[,整型参数])、substring(整型参数[,整型参数])：从子串创建字符串值。第一个参数是要获取的子串的起始位置，第二个参数是要获取的子串终止前的位置，如果省略第二参数，终止位就默认为字符串长度。这两个方法都不改变String对象自身值。当参数为正时两个方法用法及返回值均相同，只有参数有负值时才不同。对于负参数，slice()方法会用字符串的长度加上参数，substring()将其做为0处理。另外如果有两个参数，第二个比第一个小时，slice()返回的值为空，substring()会把较小的作为第一个参数。为示例：

```
var oStringObject=new String("Hello World"); 
console.log(oStringObject.slice(3));    //outpus "lo World" 
console.log(oStringObject.substring(3));    //outpus "lo World" 
console.log(oStringObject.slice(3,7));    //outpus "lo W" 
console.log(oStringObject.substring(3,7));    //outpus "lo W" 
console.log(oStringObject.slice(3,0));    //outpus (an empty string) 
console.log(oStringObject.substring(3,0));    //outpus "Hel"

console.log(oStringObject.slice(-3));    //outpus "rld"
console.log(oStringObject.substring(-3));    //outpus "Hello World"
console.log(oStringObject.slice(3,-4));    //outpus "lo W"
console.log(oStringObject.substring(3,-4));    //outpus "Hel"
```

toLowerCase()、toLocaleLowerCase()、toUpperCase()、toLocaleUpperCase()：前两个用于把字符串转换为全小写，后两个用于把字符串转换为全大写。toLowerCase()跟toUpperCase()是原始方法，toLocaleLowerCase()跟toLocaleUpperCase()是基于特定区域实现的。示例：

```
var oStringObject=new String("Hello World");
console.log(oStringObject.toLowerCase());    //outpus "hello world"
console.log(oStringObject.toLocaleLowerCase());    //outpus "hello world"
console.log(oStringObject.toUpperCase());    //outpus "HELLO WORLD"
console.log(oStringObject.toLocaleUpperCase());    //outpus "HELLO WORLD"
```

```
var oStringObject=new String("hello world");
alert(oStringObject instanceof String); //outpus "true"
```
