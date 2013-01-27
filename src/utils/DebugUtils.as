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
			var currentTime: Date = new Date();
			trace(
				"[" + currentTime.fullYear + "-" +
				(currentTime.month+1) + "-" +
				currentTime.date + " " +
				currentTime.hours + ":" +
				currentTime.minutes + ":" +
				currentTime.seconds + " " +
				className +
				"] <" + type + "> " + message);
		}
	}
}