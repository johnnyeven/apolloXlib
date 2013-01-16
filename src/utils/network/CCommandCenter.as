package utils.network 
{
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import utils.network.command.CCommandList;
	import utils.network.command.interfaces.*;
	import utils.network.command.sending.*;
	import utils.network.tcp.CNetSocket;
	
	/**
	 * ...
	 * @author john
	 */
	public class CCommandCenter extends CBaseCenter 
	{
		private var connector: CNetSocket;
		private var command: CCommandList;
		private static var instance: CCommandCenter;
		private static var allowInstance: Boolean = false;
		
		public function CCommandCenter() 
		{
			super();
			if (!allowInstance)
			{
				throw new IllegalOperationError("CCommandCenter不允许实例化");
			}
			command = CCommandList.getInstance();
			connector = CNetSocket.getInstance();
			connector.addCallback(process);
		}
		
		private function process(flag: uint, data: ByteArray): void
		{
			var protocol: INetPackageReceiving = command.getCommand(flag);
			if (protocol != null)
			{
				protocol.fill(data);
				triggerCallback(flag, protocol);
			}
		}
		
		public function add(flag: uint, processor: Function): void
		{
			addCallback(flag, processor);
		}
		
		public function remove(flag: uint, processor: Function): void
		{
			removeCallback(flag, processor);
		}
		
		public function send(protocol: CNetPackageSending): void
		{
			protocol.fill();
			connector.send(protocol.byteArray);
			CONFIG::DebugMode
			{
				trace("[CommandCenter] <Send> : Name=" + protocol.protocolName);
			}
		}
		
		public static function getInstance(): CCommandCenter
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CCommandCenter();
				allowInstance = false;
			}
			return instance;
		}
	}
}