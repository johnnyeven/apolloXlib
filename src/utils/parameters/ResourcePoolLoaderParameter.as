package utils.parameters
{
	import flash.display.DisplayObjectContainer;

	public class ResourcePoolLoaderParameter
	{
		public var url: String = "";
		public var className: String = "";
		public var displayObject: DisplayObjectContainer;
		public var onComplete: Function;
		public var onProgress: Function;
		public var onIOError: Function;
		
		public function ResourcePoolLoaderParameter()
		{
		}
	}
}