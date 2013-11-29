package objects
{
	/**
	 * ...
	 * @author Secretmapper
	 */
	public class Player extends Entity
	{
		private var _sprite:Player_lib;
		
		public function Player() 
		{
			_sprite = new Player_lib();
			//sprite.mouseEnabled = false;
			
			addChild(sprite);
		}
		
		public function get sprite():Player_lib 
		{
			return _sprite;
		}
		
	}

}