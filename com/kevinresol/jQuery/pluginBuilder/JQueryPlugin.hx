package com.kevinresol.jQuery.pluginBuilder;

import js.Browser;

/**
 * Register functions to the jQuery object in javascript
 * @author Kevin
 */

class JQueryPlugin 
{
	/**
	 * Register a function as a plugin. The registered function is called as $(id).name();
	 * @param	name
	 * @param	func
	 */
	public static function registerPlugin(name:String, func:Dynamic) 
	{
		untyped Browser.window.jQuery.prototype[name] = func;		
	}
	
	/**
	 * Register a function as utility method. The registered function is called as $.name();
	 * @param	name 
	 * @param	func
	 */
	public static function registerUtility(name:String, func:Dynamic) 
	{
		untyped Browser.window.jQuery[name] = func;		
	}
	
}

