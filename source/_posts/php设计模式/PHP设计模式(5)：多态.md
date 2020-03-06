---
title: 多态
tag: php
category: php
abbrlink: ac4294eb
date: 2016-10-13 00:00:00
modifiedOn: 2016-10-13 00:00:00
---

## Introduction

在[PHP设计模式(四)：继承][2]中我们介绍了继承，利用extends来进行程序设计的方法。  
在[PHP设计模式(二)：抽象类和接口][3]中我们介绍了接口，事实上也存在利用interface的程序设计方法，那就是多态。  
和C/C++，Java，Python等语言一样，PHP也支持多态。多态更多是是一种面向对象程序设计的概念，让同一类对象执行同一个接口，但却实现不同的逻辑功能
。

## 多态/Polymorphism

还是用动物、鲸鱼和鲤鱼来举例：

    
    
    <?php
    interface IEat {
      function eatFish();
      function eatMoss();
    }
    
    class Whale implements IEat {
      public function eatFish() {
        echo "Whale eats fish.\n";
      }
      public function eatMoss() {
        echo "Whale doesn't eat fish\n";
      }
    }
    
    class Carp implements IEat {
      public function eatFish() {
        echo "Carp doesn't eat moss.\n";
      }
      public function eatMoss() {
        echo "Carp eats moss.\n";
      }
    }
    
    $whale = new Whale();
    $whale->eatFish();
    $whale->eatMoss();
    $carp = new Carp();
    $carp->eatFish();
    $carp->eatMoss();
    ?>

运行一下：

    
    
    $ php Inheritance.php
    Whale eats fish.
    Whale doesn't eat fish.
    Carp eats moss.
    Carp doesn't eat moss.

注意PHP的函数定义不包含返回值，因此完全可以给不同的接口实现返回不同类型的数据。这一点和C/C++，Java等语言是不同的。此外，返回不同类型的数据，甚至不返回结果，对程序设计来说，会额外增加维护成本，已经和使用接口的初衷不同了（接口为了封装实现，而不同的返回值事实上是需要调用者去理解实现的）。

## 总结

合理利用多态对接口进行不同的实现，简化你的编程模型，让代码易于维护。
