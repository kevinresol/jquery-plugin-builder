package com.kevinresol.jQuery.pluginBuilder;
import haxe.macro.Context;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.Function;


/**
 * Used to inject the "_this" variable to all public static functions with method name
 * beginning in "plugin". "_this" is an alias of "this" in the javascript context
 * @author Kevin
 */
#if !macro
@:autoBuild(com.kevinresol.jQuery.pluginBuilder.PluginMacros.build())
#end
interface IPlugin { }

/**
 * Macros used to build the class which implemented IPlugin
 */
class PluginMacros
{
	#if macro
	public static function build():Array<Field>
	{
		//get all fields of the class
		var fields:Array<Field> = Context.getBuildFields();
		
		for (field in fields)
		{			
			switch(field.kind)
			{
				//this field is a function
				case FFun(f):
					//if this function is public and static
					if (field.access.indexOf(APublic) >= 0 && field.access.indexOf(AStatic) >= 0 && field.name.substr(0,6) == "plugin")
						//inject the magic expression to the function
						injectExpr(f);
				
				//this field is a property/var
				default:
			}
		}
		
		return fields;
	}
	
	private static function injectExpr(f:Function):Void
	{
		//inject the *magic expression*: "var _this = this;" 
		//so that we can use "_this" in our plugin function as a alias of "this"			
		var v = macro var _this:JQuery = untyped __js__("this");
		
		//let's look at the contents of the function
		switch(f.expr.expr)
		{
			//this function is a block
			case EBlock(b): 
				//inject the magic expression at the beginning of this function
				b.unshift(v);
				
			//this function does not have a block	
			default:
				//clone the original expression for this function
				//for some reason we cannot use the original Expr object directly
				var e = {expr:f.expr.expr, pos:f.expr.pos};
				//create a block with the magic expression at the beginning				
				f.expr.expr = EBlock([v,e]);
		}
		
	}
	#end
}
