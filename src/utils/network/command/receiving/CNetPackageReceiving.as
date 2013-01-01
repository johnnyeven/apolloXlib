package utils.network.command.receiving 
{
	import flash.utils.ByteArray;
	
	import utils.network.command.CCommandBase;
	import utils.network.command.interfaces.INetPackageReceiving;
	
	/**
	 * ...
	 * @author john
	 */
	public class CNetPackageReceiving extends CCommandBase implements INetPackageReceiving 
	{
		public var message: int;
		
		public function CNetPackageReceiving(controller: int, action: int) 
		{
			super(controller, action);
		}
		
		/* INTERFACE INetPackageReceiving */
		
		public function fill(bytes: ByteArray): void 
		{
			message = bytes.readByte();
			bytes.readShort();
		}
		
	}

}