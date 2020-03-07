---
title: 适配器模式
tag: php
category: php
abbrlink: f5c535ea
date: 2016-10-13 00:00:00
modifiedOn: 2016-10-13 00:00:00
---

## 简介

在[PHP设计模式(七)：设计模式分类](ce7fb64a.html)中我们提到过结构设计模式(Structural
patterns)，结构设计模式专注于设计对象(Object)和实例(Instance)的构建、组合过程。  
结构设计模式包括下面七种设计模式：

  1. 适配器(Adapter)

  2. 桥接(Bridge)

  3. 合成(Composite)

  4. 装饰(Decorator)

  5. 外部(Facade)

  6. 轻量(Flyweight)

  7. 代理(Proxy)

请无视拗口的中文翻译。结构设计模式着重于低耦合、高复用、高可维护性、高拓展性的设计原则。

<!--more-->

## 适配器模式

适配器模式是一种利用适配器将现有的实现，适配到已有接口的设计模式，最常见的例子就是变压器，将已有的5V输入的电器，通过变压器，适配到220V的电源插座。  
适配器模式利用[PHP设计模式(四)：继承](11d8b32d.html)中我们提到过的继承(inheritance)，以及[PHP设计模式(六)：MVC](84372d79.html)中我们提到过的组件(composition)来进行模式设计。  
相比继承，组件可用性高，低耦合，冗余度低，因此推荐采用组件的模式来进行设计。

## 何时使用适配器模式？

简单来说，当你的实现和需要的接口，都无法修改的时候。  
例如，你需要给甲方已有的系统做标准的兼容，标准不可修改，甲方的系统也不可修改，这个时候你就需要适配器的设计模式了。  
对于web编程来说，将你现有的实现，和三方库结合起来，就需要使用适配器模式。

## 使用继承的适配器模式

简单来说，就是：
```php
    <?php
    class Adapter extends YourClass implements OtherInterface
    ?>
```
还是用前面的鲸鱼和鲤鱼的例子来说明如何使用适配器，假设我们已经实现了鲸鱼类和鲤鱼类：

```php
    <?php
    class Whale {
      public function __construct() {
        $this->name = "Whale";
      }
      public function eatFish() {
        echo "Whale eat fish.\n";
      }
    }
    class Carp {
      public function __construct() {
        $this->name = "Carp";
      }
      public function eatMoss() {
        echo "Carp eat moss.\n";
      }
    }
    ?>
```
假设我们现在需要建一个动物馆，有eatFish()和eatMoss()接口，动物馆接口如下：
```php
    <?php
    interface Animal {
      function eatFish();
      function eatMoss();
    }
    ?>
```
但是我们不能修改Whale和Carp类，这里就需要使用适配器了，创建两个适配器：
```php    
    <?php
    class WhaleAdapter extends Whale implements Animal {
      public function __construct() {
        $this->name = "Whale";
      }
      public function eatMoss() {
        echo "Whale don't eat moss.\n";
      }
    }
    class CarpAdapter extends Carp implements Animal {
      public function __construct() {
        $this->name = "Carp";
      }
      public function eatFish() {
        echo "Carp don't eat moss.\n";
      }
    }
    ?>
```
然后是调用代码：
```php
    <?php
    $whaleAdapter = new WhaleAdapter();
    $whaleAdapter->eatFish();
    $whaleAdapter->eatMoss();
    $carpAdapter = new CarpAdapter();
    $carpAdapter->eatMoss();
    $carpAdapter->eatFish();
    ?>
```
运行一下：
```shell
    Whale eat fish.
    Whale don't eat moss.
    Carp eat moss.
    Carp don't eat moss.
```
## 使用组件的适配器模式

还是使用鲸鱼和鲤鱼的例子，不过这个时候适配器变成了：
```php
    <?php
    class WhaleAdapter implements Animal {
      public function __construct() {
        $this->name = "Whale";
        $this->whale = new Whale();
      }
      public function eatFish() {
        $this->whale->eatFish();
      }
      public function eatMoss() {
        echo "Whale don't eat moss.\n";
      }
    }
    class CarpAdapter implements Animal {
      public function __construct() {
        $this->name = "Carp";
        $this->carp = new Carp();
      }
      public function eatFish() {
        echo "Carp don't eat moss.\n";
      }
      public function eatMoss() {
        $this->carp->eatMoss();
      }
    }
    ?>
```
其他的地方和使用继承的适配器模式一样，这里不再赘述。

## 总结

适配器模式在不修改现有代码的基础上，保留了架构。使用继承的适配器和使用组件的适配器各有利弊，继承的类冗余度/空间复杂度偏高，组件的调用栈/时间复杂度偏高，应该结合实际情况选择。


