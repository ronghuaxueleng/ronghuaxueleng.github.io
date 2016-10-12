---
title: this关键字
tag: javascript
category: javascript
date: 2016-10-12
modifiedOn: 2016-10-12
---

* * *
> this的指向大概可以分成四种：
>  * 作为对象的方法调用
>  * 作为普通函数调用
>  * 构造器调用
>  * Function.prototype.call或Function.prototype.apply调用

### 1\. 作为对象的时候，**this指向该对象**

    
    
    var obj = {
        a: 1,
        getA: function() {
            alert(this === obj); //true;
            alert(this.a); //1
        }
    };
    obj.getA();

### 2\. 作为普通函数调用，**this总是指向全局对象（在浏览器中就是window）**

    
    
    window.name = 'globalName';
    var getName = function() {
        return this.name;
    };
    console.log(getName()); //globalName

再例如局部的callback，它作为普通函数调用时，callback内部的this指向了windows对象，解决方法则可以用一个变量保存this，例如

    
    
    document.getElemmentById('div1').onclick = function() {
        var that = this;
        var callback = function() {
            alert(that.id); //div1;
        }
        callback();
    }

### 3\. 构造器调用

当用`new`运算符调用函数时，该函数总会返回一个对象，通常情况this就是指向返回的这个对象，但如果构造器显示返回了一个object类的对象，那运算结果最终返回的是那个对象而不是this，例如

    
    
    var MyClass1 = function() {
        this.name = '111';
    }
    var obj1 = new MyClass1();
    alert(obj1.name); //111
    
    var MyClass2 = function() {
        this.name = '111';
        return { //显式的返回一个对象
            name: '222';
        }
    }
    var obj2 = new MyClass2();
    alert(obj2.name); //222
    

### 4\. Function.prototype.call或Function.prototype.apply可以动态的改变传入函数的this

  * 两者区别：传入参数不同，apply接受两个参数，第一个为this指向，第二个为一个带下标的集合，这个集合可以为数组也可以为类数组；call传入的参数数量不固定，第一个也是代表this指向，第二个开始往后每个参数被依次传入函数。

  * 改变this例子
    
    
    var obj1 = {
        name: '111';
    };
    var obj2 = {
        name: '222';
    };
    window.name = 'window';
    var getNmae = function() {
        alert(this.name);
    }
    getName(); //window
    getName.call(obj1); //111
    getName.call(obj2); //222

