package utils.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class GraphicResource
	{
		/**
		 * 原始位图 
		 */
		protected var _bitmapRaw: BitmapData;
		protected var _bitmapArray: Vector.<Vector.<BitmapData>>;
		/**
		 * 素材的行数，对于角色来说就是方向数 
		 */
		protected var _frameLine: uint = 1;
		protected var _frameTotal: uint = 1;
		protected var _fps: Number = 0;
		protected var _renderRect: Rectangle;
		private var _frameWidth: uint = 0;
		private var _frameHeight: uint = 0;
		
		public function GraphicResource()
		{
		}

		/**
		 * 分解后的位图 
		 */
		public function get bitmapArray():Vector.<Vector.<BitmapData>>
		{
			return _bitmapArray;
		}

		/**
		 * 动作的总帧数 
		 */
		public function get frameTotal():uint
		{
			return _frameTotal;
		}

		/**
		 * 动作的帧频 
		 */
		public function get fps():Number
		{
			return _fps;
		}
		
		public function set fps(value:Number):void
		{
			_fps = value;
		}

		/**
		 * 单元宽
		 */
		public function get frameWidth():uint
		{
			return _frameWidth;
		}
		
		/**
		 * 单元高
		 */
		public function get frameHeight():uint
		{
			return _frameHeight;
		}

		/**
		 * 绘制的矩形区域大小 
		 */
		public function get renderRect():Rectangle
		{
			return _renderRect;
		}
		
		public function getResource(data: BitmapData, frameLine: uint = 1, frameTotal: uint = 1, fps: Number = 0): void
		{
			_frameLine = frameLine;
			_frameTotal = frameTotal;
			_frameWidth = int(data.width / _frameTotal);
			_frameHeight = int(data.height / _frameLine);
			_fps = fps;
			_bitmapRaw = data;
			
			_bitmapArray = prepareBitmapArray();
		}
		
		/**
		 * 将大块的图片切成小片 
		 * @return Vector.<Vector.<BitmapData>>
		 * 
		 */
		private function prepareBitmapArray(): Vector.<Vector.<BitmapData>>
		{
			if(_bitmapRaw != null)
			{
				var bmArray: Vector.<Vector.<BitmapData>> = new Vector.<Vector.<BitmapData>>();
				for (var j: uint = 0; j < _frameLine; j++)
				{
					var line: Vector.<BitmapData> = new Vector.<BitmapData>();
					for (var i: uint = 0; i < _frameTotal; i++)
					{
						var bm: BitmapData = new BitmapData(_frameWidth, _frameHeight, true, 0x00000000);
						var rect: Rectangle = new Rectangle(i * _frameWidth, j * _frameHeight, _frameWidth, _frameHeight);
						bm.copyPixels(_bitmapRaw, rect, new Point(), null, null, true);
						line.push(bm);
					}
					bmArray.push(line);
				}
				return bmArray;
			}
			else
			{
				return null;
			}
		}
		
		public function renderGraphic(target: Bitmap, line: uint, frame: uint): void
		{
			if(_bitmapArray == null)
			{
				target.bitmapData = _bitmapRaw;
			}
			else
			{
				target.bitmapData = _bitmapArray[line][frame];
			}
		}
		
		public function dispose(): void
		{
			_bitmapRaw = null;
			_bitmapArray = null;
		}
	}
}