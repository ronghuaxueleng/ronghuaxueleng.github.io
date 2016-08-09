---
title: 《JavaScript高级程序设计》阅读笔记（一）：ECMAScript基础
category: JavaScript高级程序设计,ECMAScript
tags: javascript
date: 2016-08-03
modifiedOn: 2016-08-03
toc: true
---

---------
#### 语法

##### 区分大小写、变量弱类型、行尾分号可有可无、注释为双斜线、括号表明代码块

#### 变量
##### 变量用var声明，变量的命名规则：第一个字符必须是字母、下划线或美元符号；余下的字符可以是下划线、美元符号或任何字母或数字字符。

###### 变量命名规范：

 - Camel标记法：首字母小写，接下来的单词都以大写字母开头。例如：```var **m**y**T**est**V**alue=0,**m**y**S**econd**T**est**V**alue="hi"```;

 - Pascal标记法：首字母大写，接下来的单词都以大写字母开头。例如：```var **M**y**T**est**V**alue=0,**M**y**S**econd**T**est**V**alue="hi"```;

 - 匈牙利类型标记法：在以Pascal标记法命名的变量前附加一个小写字母（或小写字母序列），说明该变量的类型。例如，i表示整数，s表示字符串，如下面所示：
 
```
类型：数组　　　　前缀：a　　示例：aValues

类型：布尔型　　　前缀：b　　示例：bFound

类型：浮点型　　　前缀：f　　 示例：fValue

类型：函数　　　　前缀：fn　  示例：fnMethod

类型：整型　　　　前缀：i　　 示例：iValue

类型：对象　　　　前缀：o　　示例：oType

类型：正则　　　　前缀：re　  示例：rePatten

类型：字符串　　　前缀：s　　示例：sValue

类型：变量　　　　前缀：v　　示例：vValue
```
#### 关键字
ECMA-262 定义的关键字为：

```
break　　case　　catch　　continue　　default　　delete　　do　　else　　finally　　for　　function　　if　　in　　instanceof　　new　　return　　switch　　this　　throw　　try　　typeof　　var　　void　　while　　with
```
#### 保留字
ECMA-262第3版中保留字为：
```
abstract　　boolean　　byte　　char　　class　　const　　debugger　　double　　enum　　export　　extends　　final　　float　　goto　　implements　　import　　int　　interface　　long　　native　　package　　private　　protected　　public　　short　　static　　super　　synchronized　　throws　　transient　　volatile
```

#### 原始值和引用值

原始值(primitive value)是存储在栈(stack)中的简单数据段，也就是说，它们的值直接存储在变量访问的位置。

引用值(reference value)是存储在堆(heap)中的对象，也就是说，存储在变量处的值是一个指针(point)，指向存储对象的内存处。


