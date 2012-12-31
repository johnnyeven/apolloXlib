package utils
{
	import flash.errors.IllegalOperationError;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	import org.puremvc.as3.patterns.facade.Facade;

	public class HotkeyManager
	{
		private static var _instance: HotkeyManager;
		private static var _allowInstance: Boolean = false;
		
		private var _hotkey: Dictionary;
		
		public function HotkeyManager()
		{
			if(_allowInstance)
			{
				_hotkey = new Dictionary();
				GameManager.container.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
			else
			{
				throw new IllegalOperationError("HotkeyManager不能被实例化");
			}
		}
		
		private function onKeyDown(evt: KeyboardEvent): void
		{
			trace("HotkeyManager Info: Key down=" + keyCode);
			var keyCode: int = evt.keyCode;
			if(_hotkey[keyCode] != null)
			{
				Facade.getInstance().sendNotification(_hotkey[keyCode][0], _hotkey[keyCode][1]);
			}
		}
		
		public static function get instance(): HotkeyManager
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new HotkeyManager();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public function registerHotkey(keyCode: int, notificationName: String, command: Class, parameter: Object = null): void
		{
			_hotkey[keyCode] = [notificationName, parameter];
			if(!Facade.getInstance().hasCommand(notificationName))
			{
				Facade.getInstance().registerCommand(notificationName, command);
			}
		}
		
		public function removeHotkey(keyCode: int): void
		{
			_hotkey[keyCode] = null;
		}
	}
}