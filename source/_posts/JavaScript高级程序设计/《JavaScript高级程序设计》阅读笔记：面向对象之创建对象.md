---
title: 《JavaScript高级程序设计》阅读笔记：面向对象之创建对象
category: 《JavaScript高级程序设计》阅读笔记
tags: javascript
toc: true
abbrlink: 9c7a7c8f
date: 2016-07-30 00:00:00
modifiedOn: 2016-07-30 00:00:00
---

----------
### 创建对象
##### 工厂模式
工厂模式优点：有了封装的概念，解决了创建多个相似对象的问题

缺点：没有解决对象识别问题,所有对象都仅是Object的实例

```
function createPerson(name,age,job)
{
    var o=new Object();
    o.name=name;
    o.age=age;
    o.job=job;
    o.sayName=function(){
        alert(this.name);
    };
    return o;
}
var person1=createPerson("Jack",29,"Engineer");

//检测对象类型
alert(person1 instanceof Object) //true
alert(person1 instanceof Person) //error Person is not defined
```
##### 构造函数模式

构造函数模式相比工厂模式的优点就在于，构造函数模式可以将他的实例标示为特定类型

```
function Person(name,age,job)
{
    this.name=name;
    this.age=age;
    this.job=job;
    this.sayName=function(){
        alert(this.name);
    };
}

var person1=new Person("Jack",29,"Engineer");

//检测对象类型
alert(person1 instanceof Object) //true
alert(person1 instanceof Person) //true
```

构造函数也是函数，如果不通过new 操作符调用，和其他函数没有不同

```
function Person(name,age,job)
{
    this.name=name;
    this.age=age;
    this.job=job;
    this.sayName=function(){
        alert(this.name);
    };
}

//以构造函数模式调用
var person1=new Person("Jack",29,"Engineer");
person1.sayName();//Jack

//以普通函数调用
Person("Lily",25,"Actor");//执行环境为全局执行环节，this指向window
window.sayName();//Lily

//在另一个对象的作用域中调用
var o=new Object();
Person.apply(o,["Jim",21,"Teacher"]);//扩展Person至实例对象o的作用域
o.sayName();//Jim
```

构造函数模式缺点在于实例方法无法复用，创建两个对象person1,person2的sayName方法的不等的，解决方法可以将函数定义转至构造函数外部，构造函数这用函数指针作为对象属性，指向外部的函数定义。

但是这样的实现，首先污染了全局作用域，其次破坏了封装性

```

function Person(name,age,job)

{
    this.name=name;
    this.age=age;
    this.job=job;
    this.sayName=sayName;
}

function sayName(){
    alert(this.Name);
}

var person1=new Person("Karl",28,"Doctor");
```
##### 原型模式

每个函数都有一个prototype属性，这个属性是一个指针，指向一个对象，这个对象用途是包含可以由特定类型的所有实例共享的属性和方法

```

function Person()
{    
}

Person.prototype.name="Jim";
Person.prototype.age=29;
Person.prototype.job="Teacher";
Person.prototype.sayName=function(){
    alert(this.Name);
};

var person1=new Person();
person1.sayName();//"Jim"
var person2=new Person();
alert(person1.sayName==person2.sayName);//true
```

代码这构造函数、原型对象和实例对象之间关系如下图

![](/img/面向对象之创建对象.png)




原型模式简易写法

```
function Person()
{    
}

Person.prototype={
    constructor:Person,//对象字面量创建了新对象，如不指定，constructor指向了Object
    name:"Jim",
    age:29,
    job:"Teacher",
    sayName:function(){
        alert(this.name);
    }
};

```

原型模式的缺点：所有实例在默认情况下取得相同属性值

##### 构造器与原型混合模式
```
function Person(name,age,job)
{    
    this.name=name;
    this.age=age;
    this.job=job;
    this.friends=["Tom","Jack"];
}

Person.prototype={
    constructor:Person,//对象字面量创建了新对象，如不指定，constructor指向了Object
    sayName:function(){
        alert(this.name);
    }
};

var person1=new Person("Jim",25,"Teacher");
var person2=new Person("Lily",20,"Actor");
person1.friends.push("Mark");
alert(person1.friends===person2.friends);//false
alert(person1.sayName===person2.sayName);//true
```
##### 动态原型模式
所有代码封装在构造函数，首次调用将方法添加至原型对象

```
function Person(name,age,job)
{    
    this.name=name;
    this.age=age;
    this.job=job;
    this.friends=["Tom","Jack"];
    //方法
    if(typeof this.sayName != "function")
    {
        Person.prototype.sayName=function(){
            alert(this.name);
        };
    }
}

```
