package utils.network.command.interfaces 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public interface INetPackageSending 
	{
		function fill(): void;
		function get byteArray(): ByteArray;
		function get protocolName(): String;
	}
	
}