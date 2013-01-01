package utils.network.command 
{
	import utils.network.command.interfaces.INetPackageProtocol;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CCommandBase extends Object implements INetPackageProtocol
	{
		private var _controller: int;
		private var _action: int;
		
		public function CCommandBase(controller: int, action: int) 
		{
			super();
			_controller = controller;
			_action = action;
		}
		
		public function get controller(): int
		{
			return _controller;
		}
		
		public function get action(): int
		{
			return _action;
		}
	}

}