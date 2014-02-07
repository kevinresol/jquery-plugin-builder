jQuery Plugin Builder
=====================

Write jQuery plugins in Haxe. Basic knowledge of [writing jQuery plugins][jquery-plugin] in pure javascript is needed. 

## Step 1. Write the Plugin Function

All classes that implements the ```IPlugin``` interface will have their 
**public static** functions whose name beginning in "plugin" injected with a ```_this``` variable.
```_this``` refers to the ```this``` in the javascript context.

Under the hood it is simply a Haxe expression added to the beginning of the function: 
```haxe
var _this:JQuery = untyped __js__("this");
```
Learn more about [this][jquery-this] and [creating plugins][jquery-plugin] from the jQuery Learning Center.

### Example

```haxe
package ;
import js.JQuery;
// you can also choose to use the jQuery.JQuery from the jQueryExtern library

class MyPlugin implements IPlugin
{
	public static function pluginWithoutParameter():JQuery
	{
		// "_this" refers to "this" in the javascript context
		_this.html("pluginWithoutParameter");		
	}
	
	public static function pluginWithParameter(param:String):JQuery
	{
		// "_this" refers to "this" in the javascript context
		_this.html(param);		
	}
	
	public static function someUtilityFunction():Void
	{
		_this; // "_this" is undefined because the name of this function does not start with "plugin"	
	}
}
```
Note that the ```IPlugin``` interface is empty, meaning that no functions or properties have to be implemented.

## Step 2. Register the Plugin Function as a jQuery Plugin

Call ```JQueryPlugin.registerPlugin()``` to register the function as a plugin of jQuery. 
You may also call ```JQueryPlugin.registerUtility``` to register a [utility function][jquery-utility] for jQuery.

### Example

```haxe
class Main
{
	static function main() 
	{
		JQueryPlugin.registerPlugin("plugin", MyPlugin.pluginWithoutParameter);
		// example usage in javascript: $("body").plugin();
		
		JQueryPlugin.registerPlugin("anotherPlugin", MyPlugin.pluginWithParameter); 
		// example usage in javascript: $("body").anotherPlugin(someParameter);
		
		JQueryPlugin.registerUtility("util", MyPlugin.someUtilityFunction); 
		// example usage in javascript: $.util();		
	}
}
```

Note that your haxe-generated javascript program must be run after importing the jQuery.

### Example html
```html
<head>	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="Main.js"></script> <!--Your Haxe-generated program-->
	<script>	
	$(function()
	{		
		$('.test').plugin("param");
	})	
	</script>	
</head>
```

[jquery-this]: http://www.google.com/
[jquery-utility]: https://learn.jquery.com/using-jquery-core/utility-methods/
[jquery-plugin]: http://learn.jquery.com/plugins/basic-plugin-creation/