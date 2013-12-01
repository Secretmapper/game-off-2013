package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.hires.debug.Stats;

	/**
	 * Credits:
		 * "Gymnopedie No. 3" Kevin MacLeod (incompetech.com) 
Licensed under Creative Commons: By Attribution 3.0
http://creativecommons.org/licenses/by/3.0/
	
	
	 freesfx.co.uk 
	 */
	/**
	 * ...
	 * @author Secretmapper
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var layer:MovieClip = new MovieClip();
			addChild(new GameWorld(layer));
			addChild(layer);
		}

	}

}