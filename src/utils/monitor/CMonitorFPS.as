package utils.monitor 
{
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import utils.GameManager;
	import utils.configuration.GlobalContextConfig;
	import utils.liteui.component.Label;

	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CMonitorFPS
	{
		private var numFrames: Number = 0;
		private var interval: Number = 8;
		private var startTime: Number;
		public var fpsText: Label;
		
		public function CMonitorFPS()
		{
			startTime = getTimer();
		}

		public function start(): void
		{
			
			GameManager.container.addEventListener(Event.ENTER_FRAME, update, false, 0);
		}
		
		private function update(event:Event): void
		{
			if (++numFrames == interval)
			{
				var now:Number = getTimer();
				var elapsedSeconds: Number = (now - startTime) / 1000;
				var actualFPS:Number = numFrames / elapsedSeconds;
				fpsText.text = "Timer: " + GlobalContextConfig.Timer + ", FPS: " + actualFPS.toFixed(2);
				startTime = now;
				numFrames = 0;
			}
		}
	}

}