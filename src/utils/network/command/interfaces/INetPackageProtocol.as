package utils.network.command.interfaces 
{
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public interface INetPackageProtocol 
	{
		function get controller(): int;
		function get action(): int;
	}
	
}