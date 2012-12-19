package utils.configuration 
{
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public final class MapContextConfig 
	{
		/**
		 * 地图大小
		 */
		public static var MapSize: Point = new Point(500, 300);
		/**
		 * 地图碎片大小
		 */
		public static var TileSize: Point = new Point();
		/**
		 * 地图碎片数量
		 */
		public static var TileNum: Point = new Point();
		/**
		 * 寻路格子大小
		 */
		public static var BlockSize: Point = new Point(50, 50);
		/**
		 * 寻路格子数量
		 */
		public static var BlockNum: Point = new Point(10, 6);
		
		public function MapContextConfig() 
		{
			throw new IllegalOperationError("Config类不允许实例化");
		}
		
	}

}