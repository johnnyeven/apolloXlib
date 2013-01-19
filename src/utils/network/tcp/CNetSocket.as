package utils.network.tcp 
{
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CNetSocket extends Socket 
	{
		protected var callback: Function;
		protected static var instance: CNetSocket;
		protected static var allowInstance: Boolean = false;
		
		public function CNetSocket() 
		{
			super(null, 0);
			if (!allowInstance)
			{
				throw new IllegalOperationError("CNetSocket不允许实例化");
			}
			addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
		}
		
		public function addCallback(callback: Function): void
		{
			this.callback = callback;
		}
		
		override public function connect(host: String, port: int):void 
		{
			if (!connected)
			{
				super.connect(host, port);
			}
		}
		
		protected function onSocketData(event: ProgressEvent): void
		{
			var socketByte: ByteArray = new ByteArray();
			socketByte.endian = Endian.LITTLE_ENDIAN;
			readBytes(socketByte, 0, bytesAvailable);
			process(socketByte);
		}
		
		private function process(bytes: ByteArray): void
		{
			var packageLength: int = bytes.readShort();
			var dataByte: ByteArray = new ByteArray();
			dataByte.endian = Endian.LITTLE_ENDIAN;
			bytes.readBytes(dataByte, 0, packageLength);
			
			var ack: int = dataByte.readByte();	//调过success
			var controller: int = dataByte.readByte();
			var action: int = dataByte.readByte();
			var flag: int = (controller << 4) | action;
			dataByte.position = 0;
			
			if (callback != null)
			{
				callback(flag, dataByte);
			}
			if (bytes.bytesAvailable > 0)
			{
				process(bytes);
			}
		}
		
		public function send(bytes: ByteArray): void
		{
			if (connected)
			{
				bytes.position = 0;
				writeBytes(bytes, 0, bytes.bytesAvailable);
				flush();
			}
		}
		
		public static function getInstance(): CNetSocket
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CNetSocket();
				allowInstance = false;
			}
			return instance;
		}
	}

}