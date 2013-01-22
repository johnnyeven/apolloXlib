package utils.events
{
	import flash.events.Event;
	
	public class CommandEvent extends Event
	{
		public static const CONNECTED_EVENT: String = "CommandEvent.ConnectedEvent";
		
		public function CommandEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}