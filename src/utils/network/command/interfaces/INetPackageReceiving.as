package utils.network.command.interfaces 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public interface INetPackageReceiving 
	{
		function fill(bytes: ByteArray): void;
	}
	
}