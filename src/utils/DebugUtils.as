package utils
{
	public class DebugUtils
	{
		public function DebugUtils()
		{
		}
		
		public static function log(target: *, type: String, message: String): void
		{
			var className: String = ClassUtils.getClassName(target);
			trace("[" + className + "] <" + type + "> " + message);
		}
	}
}