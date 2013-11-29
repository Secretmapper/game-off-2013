package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import objects.BigBusinessMan;
	import objects.Civilian;
	import objects.Player;
	import flash.utils.setInterval;
	/**
	 * ...
	 * @author Secretmapper
	 */
	public class World extends MovieClip
	{
		protected var entityList:Vector.<Entity>;
		protected var civList:Vector.<Civilian>;
		
		public function World() 
		{
			entityList = new Vector.<Entity>;
			civList = new Vector.<Civilian>;
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function add(entity:Entity):void
		{
			if (entity is Civilian)
				civList.push(entity);
			entityList.push(entity);
			addChild(entity);
			entity.added();
		}
		
		public function update(e:Event = null):void
		{
			for each(var entity:Civilian in civList)
			{
				entity.update();
				if ((entity.flip && entity.sprite.x <= -50) ||(!entity.flip && entity.sprite.x > 1600))
				{
					civList.splice(civList.indexOf(entity), 1)
					entityList.splice(entityList.indexOf(entity), 1);
					removeChild(entity);
					entity = null;
				}
			}
		}
	}

}