package utils.network 
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import utils.events.CommandEvent;
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
		
		public function initialization(): void
		{
			connector.addEventListener(Event.CLOSE, onClosed);
			connector.addEventListener(Event.CONNECT, onConnected);
			connector.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			connector.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onClosed(event: Event): void
		{
			trace("服务器连接已断开");
		}
		
		private function onConnected(event: Event): void
		{
			trace("服务器已连接");
			dispatchEvent(new CommandEvent(CommandEvent.CONNECTED_EVENT));
		}
		
		private function onIOError(event: IOErrorEvent): void
		{
			trace("无法连接至服务器");
		}
		
		private function onSecurityError(event: SecurityErrorEvent): void
		{
			trace("安全沙箱冲突");
		}
		
		public function connect(host: String, port: int): void
		{
			connector.connect(host, port);
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
		
		public function dispose(): void
		{
			if(connector.hasEventListener(Event.CLOSE))
			{
				connector.removeEventListener(Event.CLOSE, onClosed);
			}
			if(connector.hasEventListener(Event.CONNECT))
			{
				connector.removeEventListener(Event.CONNECT, onConnected);
			}
			if(connector.hasEventListener(IOErrorEvent.IO_ERROR))
			{
				connector.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			}
			if(connector.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
			{
				connector.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			}
			connector.dispose();
			command.dispose();
			connector = null;
			instance = null;
		}
	}
}