jQuery Plugin Builder
=====================

Write jQuery plug-ins in Haxe.

# Usage
All classes that implements the ```IPlugin``` interface will have their 
public static functions with name beginning in "plugin" injected with a ```_this``` variable.


```_this``` refers to the ```this``` in the javascript context.
Under the hood it is simply a Haxe expression: ```haxe var _this = untyped __js__("this");```
