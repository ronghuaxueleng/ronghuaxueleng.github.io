---
title: 继承
tag: php
category: php
date: 2016-10-13
modifiedOn: 2016-10-13
---

## 简介

在[PHP设计模式(二)：抽象类和接口][2]以及[PHP设计模式(三)：封装][3]中，我们已经见过继承，也就是extends关键字。  
和C/C++，Java，Python等语言一样，PHP也支持继承，而且和其他语言没有什么区别。

## 继承/Inheritance

还是用动物、鲸鱼和鲤鱼来举例：

    
    
    <?php
    abstract class Animal {
      protected $name;
    
      protected function chew($food) {
        echo $this->name . " is chewing " . $food . ".\n";
      }
      protected function digest($food) {
        echo $this->name . " is digesting " . $food . ".\n";
      }
    }
    
    class Whale extends Animal {
      public function __construct() {
        $this->name = "Whale";
      }
      public function eat($food) {
        $this->chew($food);
        $this->digest($food);
      }
    }
    
    class Carp extends Animal {
      public function __construct() {
        $this->name = "Carp";
      }
      public function eat($food) {
        $this->chew($food);
        $this->digest($food);
      }
    }
    
    $whale = new Whale();
    $whale->eat("fish");
    $carp = new Carp();
    $carp->eat("moss");
    ?>

运行一下：

    
    
    $ php Inheritance.php
    Whale is chewing fish.
    Whale is digesting fish.
    Carp is chewing moss.
    Carp is digesting moss.

注意$this在Animal类、Whale类、Carp类中的用法。  
上面的代码看似常见，实则暗含玄机。对于一个好的程序设计，需要：

  1. 类和类之间应该是低耦合的。

  2. 继承通常是继承自抽象类，而不是具体类。

  3. 通常直接继承抽象类的具体类只有一层，在抽象类中用protected来限定。

## 总结

合理的继承对于好的程序设计同样是必不可少的，结合abstract和protected，能让你编写出结构清晰的代码。
