---
title: 原型设计模式
tag: php
category: php
abbrlink: 1e857e9f
date: 2016-10-13 00:00:00
modifiedOn: 2016-10-13 00:00:00
---

## 简介

在[PHP设计模式(八)：工厂模式][2]中我们介绍了创建设计模式(Creation
patterns)中的工厂模式，下面我们将介绍另一种原型设计模式(Prototype Method)。  
在PHP中，原型设计模式依靠cloning复制对象来实现。通过cloning构造的对象，将大量节省新对象的构造时间。

## 何时使用原型设计模式？

简单来说，当你希望根据已有的对象来创建新对象时。  
为什么会有这种需求？想象一下，你在做细胞分裂的项目，每一个细胞都是一个对象，现在你有一个细胞类，每一个新的细胞都是由这个类生成的，不同的细胞只是内部的状态参数不同。  
当分裂到第N代的时候，已经和初代大不一样了，你是愿意使用第N代的副本修改一下呢？还是愿意从初代慢慢推演？

## Example

PHP提供了内建的__clone()函数以及clone关键字，来实现对象的复制。下面给出一个例子：

    
    
    <?php
    abstract class Cell {
      public $id;
      public $dna;
      abstract function __clone();
    }
    
    class WhaleCell extends Cell {
      public function __construct() {
        $this->id = 1;
        $this->dna = "ATCG";
      }
      public function displayDNA() {
        echo $this->dna . "\n";
      }
      function __clone() {
        $this->id = $this->id + 1;
        if ($this->id % 3 == 0) {
          $this->dna = $this->dna . "AT";
        }
        if ($this->id % 5 == 0) {
          $this->dna = $this->dna . "CG";
        }
      }
    }
    
    $whaleCell = new WhaleCell();
    $whaleCell->displayDNA();
    $whaleCell2 = clone $whaleCell;
    $whaleCell2->displayDNA();
    $whaleCell3 = clone $whaleCell2;
    $whaleCell3->displayDNA();
    $whaleCell4 = clone $whaleCell3;
    $whaleCell4->displayDNA();
    $whaleCell5 = clone $whaleCell4;
    $whaleCell5->displayDNA();
    ?>

运行一下：

    
    
    ATCG
    ATCG
    ATCGAT
    ATCGAT
    ATCGATCG

程序简单的模拟了DNA的遗传突变，每遗传三代，DNA增加AT，每遗传五代，DNA增加CG。

## 原型设计模式中的构造函数

使用clone创建新对象时，并不会触发类的构造函数。这也是在使用原型设计模式中需要注意的一点。clone的底层实现并不是调用类的构造函数来创建一个类，而是直接拷贝一个类的地址空间，生成另一个类。这种直接拷贝也带来了高效。  
事实上，使用构造函数并不一定是一个好的设计，由于构造函数内的逻辑无法被外部控制，当需要修改一个类构造时的逻辑时，除了修改类的构造函数实现以外，别无他法，这破坏了类的封装。

## 总结

原型设计模式带来了另一种创建对象的思路，合理的使用cloning构造对象，将提高程序创建新对象时的效率。

