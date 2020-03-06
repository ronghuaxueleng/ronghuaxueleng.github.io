---
title: 从 JavaScript 数组去重谈性能优化
tag: javascript
category: javascript
abbrlink: a5431a21
date: 2016-10-13 00:00:00
modifiedOn: 2016-10-13 00:00:00
---
## 缘由

JavaScript 数组去重经常出现在前端招聘的笔试题里，比如：

> 有数组 `var arr = ['a', 'b', 'c', '1', 0, 'c', 1, '', 1, 0]`，请用 JavaScript
实现去重函数 `unqiue`，使得 `unique(arr)` 返回 `['a', 'b', 'c', '1', 0, 1, '']`

作为笔试题，考点有二：

  1. **正确**。别小看这个考点，考虑到 JavaScript 经常要在浏览器上运行，在千姿百态的各种浏览器环境下要保障一个函数的正确性可不是一件简单的事，不信你继续读完这篇博客。

  2. **性能**。虽然大部分情况下 JavaScript 语言本身（狭义范畴，不包含 DOM 等延拓）不会导致性能问题，但很不幸这是一道考题，因此面试官们还是会把性能作为一个考点。

在继续往下阅读之前，建议先实现一个自己认为最好的版本。

## 直觉方案

对于数组去重，只要写过程序的，立刻就能得到第一个解法：

    
    
    function unique(arr) {
      var ret = []
    
      for (var i = 0; i < arr.length; i++) {
        var item = arr[i]
        if (ret.indexOf(item) === -1) {
          ret.push(item)
        }
      }
    
      return ret
    }

直觉往往很靠谱，在现代浏览器下，上面这个函数很正确，性能也不错。但前端最大的悲哀也是挑战之处在于，要支持各种运行环境。在 IE6-8 下，数组的
`indexOf` 方法还不存在。直觉方案要稍微改造一下：

    
    
    var indexOf = [].indexOf ?
        function(arr, item) {
          return arr.indexOf(item)
        } :
        function indexOf(arr, item) {
          for (var i = 0; i < arr.length; i++) {
            if (arr[i] === item) {
              return i
            }
          }
          return -1
        }
    
    function unique(arr) {
      var ret = []
    
      for (var i = 0; i < arr.length; i++) {
        var item = arr[i]
        if (indexOf(ret, item) === -1) {
          ret.push(item)
        }
      }
    
      return ret
    }

写到这一步，正确性已没问题，但性能上，两重循环会让面试官们看了不爽。

## 优化方案

一谈到优化，往往就是八仙过海、百花齐放。但八仙往往不接地气，百花则很容易招来臭虫。数组去重的各种优化方案在此不一一讨论，下面只说最常用效果也很不错的一种。

    
    
    function unique(arr) {
      var ret = []
      var hash = {}
    
      for (var i = 0; i < arr.length; i++) {
        var item = arr[i]
        var key = typeof(item) + item
        if (hash[key] !== 1) {
          ret.push(item)
          hash[key] = 1
        }
      }
    
      return ret
    }

核心是构建了一个 `hash` 对象来替代 `indexOf`. 注意在 JavaScript 里，对象的键值只能是字符串，因此需要 `var key =
typeof(item) + item` 来区分数值 `1` 和字符串 `'1'` 等情况。

但优化真的很容易带来坑，比如上面的实现，对下面这种输入就无法判断：

    
    
    unique([ new String(1), new Number(1) ])

可以继续修改代码，做到性能和正确性都很好。但往往，这带来的结果并不好。

## 真实需求

写到这里，这篇博客才算进入正题。程序员心中都会有一些梦想，比如写出又通用性能又好的普适函数。这种梦想是让程序员变得卓越的重要内驱力，但倘若不加以控制，也很容
易走入迷途。

回到性能优化。这年头有各种各样优化，核心系统、数据库、网络、前端等等，所有这些优化，都必须回答下面这个问题：

  1. **当前有什么**。在什么场景下进行优化，场景下有哪些具体限制。理清限制很重要，限制往往带来自由。

  2. **究竟要什么**。优化的目的是什么。是提高稳定性，还是增大吞吐量，抑或减少用户等待时间。在回答这个问题之前，优化都是徒劳。对这个问题的准确回答，能为优化带来具体可测量的参数，这样优化才有目标。

  3. **可以放弃什么**。鱼与熊掌不可兼得。优化的本质是在具体场景下的取舍、权衡。什么都不愿意放弃的话，优化往往会举步维艰。


