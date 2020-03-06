---
title: 44个 Javascript 变态题解析 (上)
tag: javascript
category: javascript
abbrlink: bb77ad22
date: 2016-10-13 00:00:00
modifiedOn: 2016-10-13 00:00:00
---
原题来自: [javascript-puzzlers][1]

读者可以先去做一下感受感受. 当初笔者的成绩是 21/44...

当初笔者做这套题的时候不仅怀疑智商, 连人生都开始怀疑了....

不过, 对于基础知识的理解是深入编程的前提. 让我们一起来看看这些变态题到底变态不变态吧!

## 第1题

    
    
    ["1", "2", "3"].map(parseInt)
    

知识点:

  * [Array/map][2]
  * [Number/parseInt][3]
  * [Global_Objects/parseInt][4]
  * [JavaScript parseInt][5]

首先, map接受两个参数, 一个回调函数 callback, 一个回调函数的this值

其中回调函数接受三个参数 currentValue, index, arrary;

而题目中, map只传入了回调函数--parseInt.

其次, parseInt 只接受两个两个参数 string, radix(基数).

> 在没有指定基数，或者基数为 0 的情况下，JavaScript 作如下处理：

>

>   * 如果字符串 string 以"0x"或者"0X"开头, 则基数是16 (16进制).

>   * 如果字符串 string 以"0"开头, 基数是8（八进制）或者10（十进制），那么具体是哪个基数由实现环境决- 定。ECMAScript 5
规定使用10，但是并不是所有的浏览器都遵循这个规定。因此，永远都要明确给出radix参数的值。

>   * 如果字符串 string 以其它任何值开头，则基数是10 (十进制)。

所以本题即问

    
    
    parseInt('1', 0);
    parseInt('2', 1);
    parseInt('3', 2);
    

首先后两者参数不合法.

所以答案是 `[1, NaN, NaN]`

## 第2题

    
    
    [typeof null, null instanceof Object]
    

两个知识点:

  * [Operators/typeof][6]
  * [Operators/instanceof][7]
  * [Operators/instanceof(中)][8]

typeof 返回一个表示类型的字符串.

instanceof 运算符用来检测 constructor.prototype 是否存在于参数 object 的原型链上.

这个题可以直接看链接... 因为 `typeof null === 'object'` 自语言之初就是这样....

typeof 的结果请看下表:

    
    
    type         result
    Undefined   "undefined"
    Null        "object"
    Boolean     "boolean"
    Number      "number"
    String      "string"
    Symbol      "symbol"
    Host object Implementation-dependent
    Function    "function"
    Object      "object"
    

所以答案 `[object, false]`

## 第3题

    
    
    [ [3,2,1].reduce(Math.pow), [].reduce(Math.pow) ]
    

知识点:

  * [Array/Reduce][9]

`arr.reduce(callback[, initialValue])`

reduce接受两个参数, 一个回调, 一个初始值.

回调函数接受四个参数 `previousValue, currentValue, currentIndex, array`

需要注意的是 `If the array is empty and no initialValue was provided, TypeError
would be thrown.`

所以第二个表达式会报异常. 第一个表达式等价于 `Math.pow(3, 2) => 9; Math.pow(9, 1) =>9`

答案 `an error`

## 第4题

    
    
    var val = 'smtg';
    console.log('Value is ' + (val === 'smtg') ? 'Something' : 'Nothing');
    

两个知识点:

  * [Operators/Operator_Precedence][10]
  * [Operators/Conditional_Operator][11]

简而言之 `+` 的优先级 大于 `?`

所以原题等价于 `'Value is true' ? 'Somthing' : 'Nonthing'` 而不是 `'Value is' + (true ?
'Something' : 'Nonthing')`

答案 `'Something'`

## 第5题

    
    
    var name = 'World!';
    (function () {
        if (typeof name === 'undefined') {
            var name = 'Jack';
            console.log('Goodbye ' + name);
        } else {
            console.log('Hello ' + name);
        }
    })();
    

这个相对简单, 一个知识点:

  * [Hoisting][12]

在 JavaScript中， functions 和 variables 会被提升。变量提升是JavaScript将声明移至作用域 scope
(全局域或者当前函数作用域) 顶部的行为。

这个题目相当于

    
    
    var name = 'World!';
    (function () {
        var name;
        if (typeof name === 'undefined') {
            name = 'Jack';
            console.log('Goodbye ' + name);
        } else {
            console.log('Hello ' + name);
        }
    })();
    

所以答案是 `'Goodbye Jack'`

## 第6题

    
    
    var END = Math.pow(2, 53);
    var START = END - 100;
    var count = 0;
    for (var i = START; i <= END; i++) {
        count++;
    }
    console.log(count);
    

一个知识点:

  * [Infinity][13]
<del>在 JS 里, Math.pow(2, 53) == 9007199254740992 是可以表示的最大值. 最大值加一还是最大值.
所以循环不会停.</del>

补充: [@jelly7723][14]

> js中可以表示的最大整数不是2的53次方，而是1.7976931348623157e+308。  
2的53次方不是js能表示的最大整数而应该是能正确计算且不失精度的最大整数，可以参见js权威指南。  
9007199254740992 +1还是 9007199254740992 ，这就是因为精度问题，如果 9007199254740992 +11或者
9007199254740992 +111的话，值是会发生改变的，只是这时候计算的结果不是正确的值，就是因为精度丢失的问题。

## 第7题

    
    
    var ary = [0,1,2];
    ary[10] = 10;
    ary.filter(function(x) { return x === undefined;});
    

答案是 `[]`

看一篇文章理解稀疏数组

  * [译 JavaScript中的稀疏数组与密集数组][15]
  * [Array/filter][16]

我们来看一下 Array.prototype.filter 的 polyfill:

    
    
    if (!Array.prototype.filter) {
      Array.prototype.filter = function(fun/*, thisArg*/) {
        'use strict';
    
        if (this === void 0 || this === null) {
          throw new TypeError();
        }
    
        var t = Object(this);
        var len = t.length >>> 0;
        if (typeof fun !== 'function') {
          throw new TypeError();
        }
    
        var res = [];
        var thisArg = arguments.length >= 2 ? arguments[1] : void 0;
        for (var i = 0; i < len; i++) {
          if (i in t) { // 注意这里!!!
            var val = t[i];
            if (fun.call(thisArg, val, i, t)) {
              res.push(val);
            }
          }
        }
    
        return res;
      };
    }
    

我们看到在迭代这个数组的时候, 首先检查了这个索引值是不是数组的一个属性, 那么我们测试一下.

    
    
    0 in ary; => true
    3 in ary; => false
    10 in ary; => true
    

也就是说 从 3 - 9 都是没有初始化的'坑'!, 这些索引并不存在与数组中. 在 array 的函数调用的时候是会跳过这些'坑'的.

## 第8题

    
    
    var two   = 0.2
    var one   = 0.1
    var eight = 0.8
    var six   = 0.6
    [two - one == one, eight - six == two]
    

  * [JavaScript的设计缺陷?浮点运算：0.1 + 0.2 != 0.3][17]

IEEE 754标准中的浮点数并不能精确地表达小数

那什么时候精准, 什么时候不经准呢? 笔者也不知道...

答案 `[true, false]`

## 第9题

    
    
    function showCase(value) {
        switch(value) {
        case 'A':
            console.log('Case A');
            break;
        case 'B':
            console.log('Case B');
            break;
        case undefined:
            console.log('undefined');
            break;
        default:
            console.log('Do not know!');
        }
    }
    showCase(new String('A'));
    

两个知识点:

  * [Statements/switch][18]
  * [String][19]

switch 是严格比较, String 实例和 字符串不一样.

    
    
    var s_prim = 'foo';
    var s_obj = new String(s_prim);
    
    console.log(typeof s_prim); // "string"
    console.log(typeof s_obj);  // "object"
    console.log(s_prim === s_obj); // false
    
    

答案是 `'Do not know!'`

## 第10题

    
    
    function showCase2(value) {
        switch(value) {
        case 'A':
            console.log('Case A');
            break;
        case 'B':
            console.log('Case B');
            break;
        case undefined:
            console.log('undefined');
            break;
        default:
            console.log('Do not know!');
        }
    }
    showCase2(String('A'));
    

解释:  
`String(x) does not create an object but does return a string, i.e. typeof
String(1) === "string"`

还是刚才的知识点, 只不过 String 不仅是个构造函数 直接调用返回一个字符串哦.

答案 `'Case A'`

## 第11题

    
    
    function isOdd(num) {
        return num % 2 == 1;
    }
    function isEven(num) {
        return num % 2 == 0;
    }
    function isSane(num) {
        return isEven(num) || isOdd(num);
    }
    var values = [7, 4, '13', -9, Infinity];
    values.map(isSane);
    

一个知识点

  * [Arithmetic_Operators#Remainder][20]

此题等价于

    
    
    7 % 2 => 1
    4 % 2 => 0
    '13' % 2 => 1
    -9 % % 2 => -1
    Infinity % 2 => NaN
    

需要注意的是 余数的正负号随第一个操作数.

答案 `[true, true, true, false, false]`

## 第12题

    
    
    parseInt(3, 8)
    parseInt(3, 2)
    parseInt(3, 0)
    

第一个题讲过了, 答案 `3, NaN, 3`

## 第13题

    
    
    Array.isArray( Array.prototype )
    

一个知识点:

  * [Array/prototype][21]

一个鲜为人知的实事: `Array.prototype => []`;

答案: `true`

## 第14题

    
    
    var a = [0];
    if ([0]) {
      console.log(a == true);
    } else {
      console.log("wut");
    }
    

  * [JavaScript-Equality-Table][22]
  * _更新_[通过一张简单的图，让你彻底地、永久地搞懂JS的==运算][23] 非常不错的一篇文章!

解析:

  * `Boolean([0]) === true`
  * [0] == true 
    * true 转换为数字 =&gt; 1
    * [0] 转化为数字失败, 转化为字符串 '0', 转化成数字 =&gt; 0
    * 0 !== 1

答案: `false`

## 第15题

    
    
    []==[]
    
    

[] 是Object, 两个 Object 不相等

答案是 `false`

## 第16题

    
    
    '5' + 3
    '5' - 3
    

两个知识点:

  * [Arithmetic_Operators#Addition][24]
  * [Arithmetic_Operators#Subtraction][25]

`+` 用来表示两个数的和或者字符串拼接, `-`表示两数之差.

请看例子, 体会区别:

    
    
    > '5' + 3
    '53'
    > 5 + '3'
    '53'
    > 5 - '3'
    2
    > '5' - 3
    2
    > '5' - '3'
    2
    

也就是说 `-` 会尽可能的将两个操作数变成数字, 而 `+` 如果两边不都是数字, 那么就是字符串拼接.

答案是 `'53', 2`

## 第17题

    
    
    1 + - + + + - + 1
    
    

这里应该是(倒着看)

    
    
    1 + (a)  => 2
    a = - (b) => 1
    b = + (c) => -1
    c = + (d) => -1
    d = + (e) => -1
    e = + (f) => -1
    f = - (g) => -1
    g = + 1   => 1
    

所以答案 `2`

## 第18题

    
    
    var ary = Array(3);
    ary[0]=2
    ary.map(function(elem) { return '1'; });
    

稀疏数组. 同第7题.

题目中的数组其实是一个长度为3, 但是没有内容的数组, array 上的操作会跳过这些未初始化的'坑'.

所以答案是 `["1", undefined × 2]`

这里贴上 Array.prototype.map 的 polyfill.

    
    
    Array.prototype.map = function(callback, thisArg) {
    
            var T, A, k;
    
            if (this == null) {
                throw new TypeError(' this is null or not defined');
            }
    
            var O = Object(this);
            var len = O.length >>> 0;
            if (typeof callback !== 'function') {
                throw new TypeError(callback + ' is not a function');
            }
            if (arguments.length > 1) {
                T = thisArg;
            }
            A = new Array(len);
            k = 0;
            while (k < len) {
                var kValue, mappedValue;
                if (k in O) {
                    kValue = O[k];
                    mappedValue = callback.call(T, kValue, k, O);
                    A[k] = mappedValue;
                }
                k++;
            }
            return A;
        };
    

## 第19题

    
    
    function sidEffecting(ary) {
      ary[0] = ary[2];
    }
    function bar(a,b,c) {
      c = 10
      sidEffecting(arguments);
      return a + b + c;
    }
    bar(1,1,1)
    
    

这是一个大坑, 尤其是涉及到 ES6语法的时候

知识点:

  * [Functions/arguments][26]

首先 `The arguments object is an Array-like object corresponding to the
arguments passed to a function.`

也就是说 `arguments` 是一个 `object`, c 就是 arguments[2], 所以对于 c 的修改就是对 arguments[2]
的修改.

所以答案是 `21`.

然而!!!!!!

当函数参数涉及到 `any rest parameters, any default parameters or any destructured
parameters` 的时候, 这个 arguments 就不在是一个 `mapped arguments object` 了.....

请看:

    
    
    function sidEffecting(ary) {
      ary[0] = ary[2];
    }
    function bar(a,b,c=3) {
      c = 10
      sidEffecting(arguments);
      return a + b + c;
    }
    bar(1,1,1)
    

答案是 `12` !!!!

请读者细细体会!!

## 第20题

    
    
    var a = 111111111111111110000,
        b = 1111;
    a + b;
    
    

答案还是 `111111111111111110000`. 解释是 `Lack of precision for numbers in JavaScript
affects both small and big numbers.` 但是笔者不是很明白................ 请读者赐教!

## 第21题

    
    
    var x = [].reverse;
    x();
    

这个题有意思!

知识点:

  * [Array/reverse][27]

`The reverse method transposes the elements of the calling array object in
place, mutating the array, and returning a reference to the array.`

也就是说 最后会返回这个调用者(this), 可是 x 执行的时候是上下文是全局. 那么最后返回的是 `window`.

补充:

> [@stellar91][28] 这个笔者实践了一下 发现 firefox 是 window, chrome 报错 `VM190:2 Uncaught
TypeError: Array.prototype.reverse called on null or undefined(…)` 可能是实现不同, 在
chrome 中应该是对调用者做了检查.

答案是 `window`

## 第22题

    
    
    Number.MIN_VALUE > 0
    

`true`

#

今天先到这里, 下次我们来看后22个题!

[44个 Javascript 变态题解析 (下)][29]

   [1]: http://javascript-puzzlers.herokuapp.com/

   [2]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map

   [3]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/parseInt

   [4]: https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/parseInt

   [5]: http://www.w3school.com.cn/jsref/jsref_parseInt.asp

   [6]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/typeof

   [7]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/instanceof

   [8]: https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/instanceof

   [9]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce

   [10]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence

   [11]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Conditional_Operator

   [12]: https://developer.mozilla.org/en-US/docs/Glossary/Hoisting

   [13]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Infinity

   [14]: https://github.com/jelly7723

   [15]: http://www.cnblogs.com/ziyunfei/archive/2012/09/16/2687165.html

   [16]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter

   [17]: http://ourjs.com/detail/54695381bc3f9b154e000046

   [18]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/switch

   [19]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String

   [20]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder

   [21]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/prototype

   [22]: https://dorey.github.io/JavaScript-Equality-Table/

   [23]: https://zhuanlan.zhihu.com/p/21650547

   [24]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Addition

   [25]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Subtraction

   [26]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments

   [27]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reverse

   [28]: https://github.com/stellar91

   [29]: https://github.com/xiaoyu2er/blog/issues/3

