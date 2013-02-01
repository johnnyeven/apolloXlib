package utils
{
	import flash.utils.getQualifiedClassName;
	
	public class ClassUtils
	{
		public function ClassUtils()
		{
		}
		
		public static function getFullClassName(target: *): String
		{
			return getQualifiedClassName(target);
		}
		
		public static function getClassName(target: *): String
		{
			var className: String = getFullClassName(target);
			var seperator: String = "::";
			var i: int = className.indexOf(seperator);
			return className.slice(i + seperator.length);
		}
		
		public static function getPackageName(target: *): String
		{
			var className: String = getFullClassName(target);
			var i: int = className.indexOf("::");
			return className.slice(0, i);
		}
	}
}