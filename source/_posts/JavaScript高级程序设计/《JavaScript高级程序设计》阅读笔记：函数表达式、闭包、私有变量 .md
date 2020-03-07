---
title: 《JavaScript高级程序设计》阅读笔记：函数表达式、闭包、私有变量
category: 《JavaScript高级程序设计》阅读笔记
tags: javascript
toc: true
abbrlink: 4bbe7293
date: 2016-07-29 00:00:00
modifiedOn: 2016-07-29 00:00:00
---

----------
#### 定义函数有两种方式：函数声明和函数表达式。它们之间一个重要的区别是函数提升。

<!-- more -->

##### 1.函数声明会进行函数提升，所以函数调用在函数声明之前也不会报错：

```

test();

function test(){

alert(1);

}

```

##### 2.函数表达式不会进行函数提升，函数调用在函数声明之前的话会报错：

```

test(); // test is not a function

var test=function(){

alert(1);

}

```
----------
#### 递归函数是通过在函数内部调用自身实现的。

##### 直接使用函数名进行递归调用

```

function f(num){

  if(num==1){

  return 1;

  }else{

  return num*f(num-1);

  }

}

console.log(f(4));//24

console.log(f(5));//120

```

这种实现的缺点是，在函数内部直接写死了函数名称。如果进行如下设置就会报错：

```

var test=f;

f=null;

console.log(test(3));//报错， f is not a function

```

##### 通过arguments.callee解决，arguments.callee是一个指向正在执行的函数的指针。这样就避免了上述问题。

```

function f(num){

  if(num==1){

  return 1;

  }else{

  return num*arguments.callee(num-1);

  }

}

console.log(f(4));//24

console.log(f(5));//120

var test=f;

f=null;

console.log(test(3));//6

```

不过这种方式还有一个缺点，就是在严格模式下会执行失败。

添加"use strict"后执行会报错：

```

'caller', 'callee', and 'arguments' properties may not be accessed on strict mode functions or the arguments objects for calls to them

```

##### 采用命名函数表达式可以在严格模式下成功。

```

"use strict";

var f=function t(num){

if(num==1){

  return 1;

  }else{

  return num*t(num-1);

  }

}

console.log(f(4));//24

console.log(f(5));//120

var test=f;

f=null;

console.log(test(3));//6

```
----------

#### 闭包是有权访问另一个函数作用域内变量的函数。创建闭包的常见方式就是在一个函数内创建另外一个函数。在另一个函数内部定义的函数，会把外部函数的作用域添加到其作用域链中。

##### 闭包与变量

###### 闭包只能取得包含函数中任意变量的最后一个值。例如：

```

function createFunctions(){

  var result=new Array();

  for(var i=0;i<10;i++){

    result[i]=function(){

    return i;

    }

  }

  return result;

}

var result=createFunctions();

result[1]();//10

```

这个方法调用传入1-10返回结果都是10，这并不符合预期。

###### 通过匿名函数进行改造：

```

function createFunctions(){

  var result=new Array();

  for(var i=0;i<10;i++){

    result[i]=(function(num){

    return num;

    })(i);

  }

  return result;

}

var result=createFunctions();

result[2];//2

```

改造后的运行结果符合我们的预期了。因为将i传递给num命名参数时是按值传递的。

##### 闭包中的this

this变量是在运行时基于函数的执行环境绑定的。

在全局执行环境中，this指向window对象；

当函数作为某个对象的方法时，this等于那个对象；

匿名函数的执行具有全局性，this通常指向window对象。

###### 闭包中this实例：

```

var name='window';

var object={

  name:"object",

  getName:function(){

    return function(){

        return this.name;

    }

} 

};

object.getName()();//window

```

###### 先将闭包外部作用域中的this保存到一个闭包能访问到的变量中，这样就可以让闭包访问相应的对象了。例如：

```

var name='window';

var object={

  name:"object",

  getName:function(){

var that=this;

     return function(){      

        return that.name;

    }

} 

};

object.getName()();//object

```

