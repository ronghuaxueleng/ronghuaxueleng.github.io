---
title: 工厂模式
tag: php
category: php
abbrlink: 54788f73
date: 2016-10-13 00:00:00
modifiedOn: 2016-10-13 00:00:00
---

## 简介

在[PHP设计模式(七)：设计模式分类][2]中我们提到过创建设计模式(Creation
patterns)，创建设计模式专注于设计对象(Object)和实例(Instance)的创建过程。  
创建设计模式包括下面五种设计模式：

  1. 抽象工厂设计模式(Abstract Factory)

  2. 生成器模式(Builder)

  3. 工厂设计模式(Factory Method)

  4. 原型设计模式(Prototype Method)

  5. 单例设计模式(Singleton)

当程序逐渐扩展的时候，需要更多的新对象，新对象的创建不应该依赖于创建者，换句话说，新对象的创建过程，不应该依赖调用创建函数的对象。为了减少冗余，增加拓展性，工厂模式就是一种创建新对象时使用的设计模式。

## 工厂模式

工厂模式，也是五种设计模式中唯一的类的设计模式(Class patterns)，即在类中就能实现的设计模式。  
听起来挺抽象？对比原型设计模式，这是一种对象设计模式(Object patterns)，通过对象的__clone()方法来实现的设计模式。  
在工厂模式中，新创建的对象/产品并不依赖于生产它的对象/工厂，新对象和调用者之间是低耦合状态。通常调用者和工厂交互，由工厂来生成新对象，新对象只和工厂有关。

## 何时使用工厂模式？

简单来说，当需求对类的个数不明确的时候，可以使用工厂模式，如：  
你需要创建一个在线博物馆，但你并不确切的知道究竟有多少文物，你不可能无限的增加新的文物类，同时对于损毁的文物，你不可能无限的去清理这些类。  
反过来说，如果你确切的知道类的总量，那么你就没有必要使用工程模式，直接通过继承的方式就能实现好的设计。

## Example

还是使用我们惯用的鲸鱼和鲤鱼的例子，现在我们想实现一个海洋馆，目前我们并不确定究竟有多少海洋生物。  
先是一个抽象的工厂类：

    
    
    <?php
    abstract class Factory {
      protected abstract function create();
      public function factoryStart() {
        return $this->create();
      }
    }
    ?>

然后是两个工厂：鲸鱼工厂和鲤鱼工厂

    
    
    <?php
    class WhaleFactory extends Factory {
      protected function create() {
        $whale = new Whale();
        return $whale->create();
      }
    }
    class CarpFactory extends Factory {
      protected function create() {
        $carp = new Carp();
        return $carp->create();
      }
    }
    ?>

然后是抽象的动物接口：

    
    
    <?php
    interface Animal {
      public function create();
    }
    ?>

然后是具体的动物类：鲸鱼类和鲤鱼类

    
    
    <?php
    class Whale implements Animal {
      private $name;
      public function create() {
        $this->name = "Whale";
        return $this->name . " is created.\n";
      }
    }
    class Carp implements Animal {
      private $name;
      public function create() {
        $this->name = "Carp";
        return $this->name . " is created.\n";
      }
    }
    ?>

下面给出使用工厂创建鲸鱼和鲤鱼的代码：

    
    
    <?php
    $whaleFactory = new WhaleFactory();
    echo $whaleFactory->factoryStart();
    $carpFactory = new CarpFactory();
    echo $carpFactory->factoryStart();
    ?>

运行一下：

    
    
    Whale is created.
    Carp is created.

到这里你是不是觉得，其实直接生成两个类就行了，何必搞这么复杂？别着急，好戏在后面。

## 修改类的方法

由于Interface的限制，修改类的方法被限定在了create()方法中，因此可以避免偷懒的程序员新增加的不合理函数。  
简单修改一下：

    
    
    <?php
    class Whale implements Animal {
      private $name;
      public function create() {
        $this->name = "Whale";
        return $this->name . " is created. Whale eats fish.\n";
      }
    }
    class Carp implements Animal {
      private $name;
      public function create() {
        $this->name = "Carp";
        return $this->name . " is created. Carp eats moss.\n";
      }
    }
    ?>

由于对象是由工厂造出来的，外部不可能直接调用或者修改类的实现，类的修改被限定在了类的对外接口上。这样的架构易于扩展。

## 一个工厂

工厂模式的灵活，在于可以只拥有一个工厂，却能生产多个类/产品。  
修改我们的抽象工厂，给create()方法增加animal接口：

    
    
    <?php
    abstract class Factory {
      protected abstract function create(Animal $animal);
      public function factoryStart($animal) {
        return $this->create($animal);
      }
    }
    ?>

然后合并之前的鲸鱼工厂和鲤鱼工厂：

    
    
    <?php
    class AnimalFactory extends Factory {
      protected function create(Animal $animal) {
        return $animal->create();
      }
    }
    ?>

修改使用工厂创建鲸鱼和鲤鱼的代码：

    
    
    <?php
    $animalFactory = new AnimalFactory();
    echo $animalFactory->factoryStart(new Whale());
    echo $animalFactory->factoryStart(new Carp());
    ?>

运行一下：

    
    
    Whale is created. Whale eats fish.
    Carp is created. Carp eats moss.

鲸鱼类和鲤鱼类源源不断的从一个工厂中被创建出来了。通过这种设计模式，类的创建过程统一通过一个接口来实现，接口外部并不需要关心类是如何被创建出来的，而接口内部实现也得到了很好的拓展性。

## 总结

本文介绍了工厂设计模式，使用这种设计模式，可以让你通过一个或多个工厂的接口，创建无数新类，调用任意类的方法。由于接口严格定义了新类/产品的形态，因此在维护和
拓展的时候，可以省去不少力气。

