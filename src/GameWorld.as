package  
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.ui.MultitouchInputMode;
	import objects.Civilian;
	import objects.CivilianOne;
	import objects.CivilianTwo;
	import objects.Player;
	import objects.BigBusinessMan;
	import utils.number.randomWithinRange;
	import utils.number.randomIntegerWithinRange;
	import utils.textField.TextFieldWrapper;
	import flash.utils.setInterval;
	import com.greensock.TweenMax;
	import com.greensock.TimelineMax;
	import flash.net.navigateToURL;
	/**
	 * Warning to viewer:
	 * The code consists of:
		 * Patches of Electrical Tape
		 * Strong Glue
		 * The Occassional kick
	 * It is horrendous.
	 * I suggest you kindly step away.
	 * Thank you :)
	 * @author Secretmapper
	 */
	public class GameWorld extends World
	{
		public var money:int;
		//TODO: HUD!!! Instance Name
		public var hud_f:Hud_lib;
		public var counter:int;
		
		private var cameraVel:int = 0;
		
		protected 	var tut:Tut_lib;
		protected var tutInt:int = 0;
		protected var back:MovieClip;
		
		protected var timeline:TimelineMax;
		
		protected var biggieCounter:int;
		
		[Embed(source = "../assets/Gymnopedie No 3.mp3")]
		private var song:Class;
		
		//[Embed(source="../assets/valencia.mp3")]
		//private var streetnoise:Class;
		
		public function GameWorld(layer:MovieClip) 
		{
			super();
			
			money = 0;
			hud_f = new Hud_lib;
			
			//hud_f.x += hud_f.width / 2;
			hud_f.y += hud_f.height / 2 - 3;
			hud_f.coinsTxt.text = "0";
			hud_f.coinsTxt.text = "0";
			
			counter = 0;
			var lightbox:Lightbox_lib = new Lightbox_lib();
			lightbox.x = lightbox.width / 2;
			lightbox.y = lightbox.height / 2;
			layer.addChild(lightbox);
			lightbox.mouseEnabled = lightbox.mouseChildren = false;
			
			layer.addChild(hud_f);
			
			back = new Background_lib();
			back.y = 500 / 2  + hud_f.height / 2;
			back.x = 667 / 2;
			addChild(back);
			
			var player:Player = new Player();
			player.x = 1100;
			player.y = 300 + hud_f.height / 2;
			player.sprite.width = 380;
			player.sprite.height = 210.95;
			
			var bird:Bird_lib = new Bird_lib();
			bird.buttonMode = true;
			bird.x = 1100;
			bird.y = 87;
			//bird.x = 770;
			//bird.y = -195.85;
			
			addChild(bird);
			add(player);
			
			timeline = new TimelineMax();
			
			var s:Sound = new song as Sound;
			s.play(0, 30, new SoundTransform(0.425, 0));
			
			//var street:Sound = new streetnoise as Sound;
			//street.play(0, 30, new SoundTransform(0.075,0));
			
			var left:Scroll_left_lib = new Scroll_left_lib();
			left.y = 300;
			left.x = left.width;
			layer.addChild(left);
			left.buttonMode = true;
			left.addEventListener(MouseEvent.MOUSE_OVER, onCamera);
			left.addEventListener(MouseEvent.MOUSE_OUT, onCameraOut);
			left.stop();
			
			var mc:Scroll_right_lib = new Scroll_right_lib();
			mc.x = 667 - mc.width;
			mc.y = 300;
			mc.buttonMode = true;
			mc.addEventListener(MouseEvent.MOUSE_OVER, onCamera);
			mc.addEventListener(MouseEvent.MOUSE_OUT, onCameraOut);
			mc.stop();
			
			layer.addChild(mc);
			
			tut  = new Tut_lib();
			tut.x = 667 / 2;
			tut.y = 450;
			layer.addChild(tut);
			tut.tutText.text = "Hover over the left and right arrows to move the camera";
			tutInt = 0;
			
			var donate:Donate_lib = new Donate_lib();
			donate.y = 525 - (donate.height /2 );
			donate.x = 667 - (donate.width / 2 );
			donate.addEventListener(MouseEvent.CLICK, onDonate);
			donate.buttonMode = true;
			layer.addChild(donate);
			
			this.x = -750;
			
			biggieCounter = 10;
			layer.mouseEnabled = false;
		}
		
		protected function onDonate(e:MouseEvent):void
		{
			var url:URLRequest = new URLRequest("http://charitygamejam.com/");
			navigateToURL(url, "_blank");
		}
		
		protected function onCamera(e:MouseEvent):void
		{
			if (e.currentTarget is Scroll_left_lib)
			{
				cameraVel += 10;
				
				(e.currentTarget as MovieClip).play();
			}
			else
			{
				cameraVel -= 10;
				
				(e.currentTarget as MovieClip).play();
			}
			if(tutInt == 0)
				//TweenMax.delayedCall(2, updateTutorial);
				updateTutorial();
		}
		
		/* Dear Programmer,
		 * The following code is horrendous
		 * Do not try to be a smartass and change/add something.
		 * Use your time more productively
		 * Your time is too important to optimize the following.
		 * If you must, Go overhaul it or something.
		 */
		protected function updateTutorial():void
		{
			if (tutInt == 0)
			{
				timeline.add(TweenMax.to(tut, 1, { y:"+25", alpha:0, onComplete:function():void
					{tut.tutText.text = "You need money in order to survive"; }} ).delay(2));
				timeline.add(TweenMax.to(tut, 1, { y:"-25", alpha:100 } ).delay(2));
				timeline.add(TweenMax.to(tut, 1, { y: "+25", alpha:0, onComplete:function():void
					{tut.tutText.text = "Look for a civilian to beg on"; }} ).delay(2));
				timeline.add(TweenMax.to(tut, 1, { y:"-25", alpha:100,  onComplete:function():void
					{ timeline.stop(); spawn(); setInterval(spawnProcess, 10000); tutInt = 1; }} ).delay(2));
			}
			else if (tutInt == 1)
			{
				tutInt = 2;
				timeline = new TimelineMax();
				timeline.play();
				timeline.add(TweenMax.to(tut, 1, { y:"+25", alpha:0, onComplete:function():void
					{tut.tutText.text = "Click the civilian to beg for money"; }} ).delay(2));
				timeline.add(TweenMax.to(tut, 1, { y:"-25", alpha:100 } ).delay(2));
				
				timeline.add(TweenMax.to(tut, 1, { y:"+25", alpha:0, onComplete:function():void
					{tut.tutText.text = "You can keep on begging a single civilian"; }} ).delay(2));
				timeline.add(TweenMax.to(tut, 1, { y:"-25", alpha:100 } ).delay(2));
				
				timeline.add(TweenMax.to(tut, 1, { y:"+25", alpha:0, onComplete:function():void
					{tut.tutText.text = "Remember, spare CHANGE can CHANGE a life"; }} ).delay(2));
				timeline.add(TweenMax.to(tut, 1, { y:"-25", alpha:100 } ).delay(2));
				
				timeline.add(TweenMax.to(tut, 1, { y:"+25", alpha:0,  onComplete:function():void
					{ timeline.stop(); TweenMax.delayedCall(5, trivia); }} ).delay(2));
				
			}
				
			//timeline.add(TweenMax.to(tut, 0.3, { x:"+5", alpha:100 } ));
			/*if (tutInt != 0 && !(tutInt % 2 == 0))
			{
				if (tutInt == 1)
				{
					tut.tutText.text = "You need money in order to survive";
				}
				else if (tutInt == 3)
				{
					tut.tutText.text = "Look for a civilian to beg on";
				}
				if (tutInt < 3)
				{
					TweenMax.to(tut, 0.3, { y: "+5", alpha:100 } );
					tutInt++;
				}
			}
			else if (tutInt == 0)
			{
				TweenMax.to(tut, 0.3, { y: "-5", alpha:0 } );
				tutInt++;
			}
			else if (tutInt % 2 == 0)
			{
				TweenMax.to(tut, 0.3, { y: "-5", alpha:0 } );
				tutInt++;
			}
			
			
			TweenMax.delayedCall(3, updateTutorial);*/
			//if (civList.length > 0)
				//trace(civList[0].sprite.localToGlobal(new Point()).x);
		}
		
		protected function trivia():void
		{
			timeline = new TimelineMax();
			timeline.play();
			quoteWrapper("1 in 4 people earn less than $1 a day");
			quoteWrapper("70 percent of poor people are women");
			quoteWrapper("One third of deaths are due to poverty-related causes");
			
			quoteWrapper("Six Million Children die of Hunger every Year");
			
			quoteWrapper("Malnutrition account for 58 percent of the total mortality rate in 2006");
			quoteWrapper("Eighty percent of malnourished children live in countries with food surpluses");
			quoteWrapper("90% of the hungriest nations on earth are net exporters of food to rich nations");
			quoteWrapper("More than half of all adults in the United States are overweight");
			quoteWrapper("There are more overweight people in the world than undernourished ones");
			
			quoteWrapper("Money spent on weight-loss programs are five times the amount needed to solve world hunger");
			quoteWrapper("Money spent on pet food is more than the amount needed to solve world hunger");
			
			quoteWrapper("The 100 thousand tons of food wasted everyday is enough to feed the hungry");
			quoteWrapper("35% of school lunches end up in the bin");
			
			quoteWrapper("There are over 100 million street children worldwide");
			quoteWrapper("Poverty has drastic effects to children's success in school");
			quoteWrapper("Deterioration of living contitions compel children to abandon school");
			quoteWrapper("Every year 11 million children die before their fifth birthday");
			
			quoteWrapper("The Poorest fifth receive 0.1% of the world\'s lighting");
			
			quoteWrapper("Low quality roads in Africa means that it is more expensive to move fertilizer inland than importing costs");
			
			quoteWrapper("16 percent of the world has iodine deficiency, lowering intelligence by 10 to 15 I.Q. points");
			
			quoteWrapper("In Canada, it takes two days, two registration procedures and $280 to open a business");
			quoteWrapper("In Bolivia, it takes 82 days, 20 procedures and $2696 to do the same");
			
			quoteWrapper("Typhoon Haiyan killed at least 5,560 people in the Philippines");
			quoteWrapper("Climatologists have connected the extreme weather to climate change");
			quoteWrapper("Extreme infrastructure damage greatly slowed relief efforts");
			quoteWrapper("Widespread looting took place due to the extreme conditions");
			quoteWrapper("The Typhoon left 1.9 million homeless");
			
			quoteWrapper("The rich is getting richer and the poor is getting poorer");
			quoteWrapper("India loses $2 billion a year due to brain drain");
			quoteWrapper("In the U.S. Alone, 8.1 million people are working part time even though they wanted full-time work.", true);
		}
		
		protected function quoteWrapper(string:String, end:Boolean = false):void
		{
			timeline.add(TweenMax.to(tut, 1, { y: "+25", alpha:0, onComplete:function():void
					{tut.tutText.text = string; }} ).delay(5));
			if(!end)
				timeline.add(TweenMax.to(tut, 1, { y:"-25", alpha:100 } ).delay(5));
			else
			timeline.add(TweenMax.to(tut, 1, { y:"-25", alpha:100,  onComplete:function():void
					{ trivia(); }} ).delay(2));
		}
		
		protected function onCameraOut(e:MouseEvent):void
		{
			(e.currentTarget as MovieClip).gotoAndStop(1);
			cameraVel = 0;
		}
		
		override public function update(e:Event = null):void 
		{
			super.update();
			
			for each(var entity:Civilian in civList)
			{
				entity.update();
				if ((entity.flip && entity.sprite.x <= -1200) ||(!entity.flip && entity.sprite.x > 1600))
				{
					civList.splice(civList.indexOf(entity), 1)
					entityList.splice(entityList.indexOf(entity), 1);
					removeChild(entity);
					entity.destroy();
					entity.removeEventListener(MouseEvent.CLICK, onCivClick);
					entity = null;
				}
			}
			
			if (cameraVel > 0)
			{
				if(!(this.x >= 850))
					this.x += cameraVel;
			}
			if (cameraVel < 0)
			{
				if((this.x >= -825))
					this.x += cameraVel;
			}
			
			if (civList.length == 1 && tutInt == 1)
			{
				
				var civX:int = civList[0].sprite.localToGlobal(new Point()).x;
				trace(civX);
				if (civX >= 0 && civX <= 667)
				{
					updateTutorial();
				}
			}
		}
		
		public function spawnProcess():void
		{
				
				/*if (randomWithinRange(0, 100) <= 5)
				{
					var civ:CivilianOne = new CivilianOne();
					civ.addEventListener(MouseEvent.CLICK, onCivClick);
					civ.y = 325;
					add(civ);
				}
				if (randomWithinRange(0, 100) <= 2)
				{
					var civ2:CivilianTwo = new CivilianTwo();
					civ2.addEventListener(MouseEvent.CLICK, onCivClick);
					civ2.y = 325;
					add(civ2);
				}*/
				if (tutInt < 2)
					return;
					
					spawn();
				if (counter == 4)
				{
					food();
					counter = 0;
				}
				counter++;
		}
		
		public function spawn():void
		{
			biggieCounter--;

			var flip:Boolean = false;
			if (randomIntegerWithinRange(0, 1) == 0)
				flip = true;
			
			if (randomIntegerWithinRange(0,  5) == 0 || biggieCounter <= 0) //not so random randomness
			{
				biggieCounter = 10;
				var bbm:BigBusinessMan = new BigBusinessMan(flip);
					//bbm.sprite.scaleX = bbm.sprite.scaleY = 0.75;
					bbm.addEventListener(MouseEvent.CLICK, onCivClick);
					bbm.sprite.x = (flip) ? 1600  : -1000;
					bbm.y = 450;
					add(bbm);
			} else
			{
				var civ:CivilianOne = new CivilianOne(flip);
					//bbm.sprite.scaleX = bbm.sprite.scaleY = 0.75;
					civ.addEventListener(MouseEvent.CLICK, onCivClick);
					civ.sprite.x = (flip) ? 1600  : -1000;
					civ.y = 450;
					add(civ);
			}
		}
		
		override public function add(entity:Entity):void 
			{
				super.add(entity);
				if (entity is Civilian)
				{
					entity.y += randomIntegerWithinRange(0, 50)
					sortChildrenByFauxZ(null);
				}
			}
		protected function onCivClick(e:MouseEvent):void
		{
			var civ:Civilian = (e.currentTarget as Civilian);
			if (civ.clicked())
			{
				money += civ.money;
				hud_f.coinsTxt.text = Math.max(0, money).toString();
				var pText:Plus_Text_lib = new Plus_Text_lib();
				pText.x = 500;
				pText.y = 10;
				pText.plusText.text = "+ " + civ.money;
				hud_f.addChild(pText);
				TweenMax.to(pText, 1, { alpha:0, y:"+15", onComplete:function():void { hud_f.removeChild(pText);  pText = null; } }).delay(2);
			}
			
		}
		
		protected function food():void
		{
			money -= 10;
			if (money < 0)
			{
				money = 0;
				return;
			}
			//money -= Math.max(0, money);
			hud_f.coinsTxt.text = money.toString();
			var pText:MovieClip = new Minus_Text_lib();
			pText.x = 500;
			pText.y = 10;
			hud_f.addChild(pText);
			TweenMax.to(pText, 1, { alpha:0, y:"+15", onComplete:function():void { hud_f.removeChild(pText);  pText = null; } } ).delay(2);
		}
		
		public function sortChildrenByFauxZ( container:DisplayObjectContainer ) : Boolean
		{
			var numChildren:int = numChildren;
			//no need to sort (zero or one child)
			if( numChildren < 2 ) return false;
			
			var depthsSwapped:Boolean;
			
			//create an Array to sort children
			var children:Array = new Array( numChildren );
			var i:int = -1;
			while( ++i < numChildren )
			{
				children[ i ] = getChildAt( i );
			}
			
			//sort by children's y position
			children.sortOn( "y", Array.NUMERIC );
			
			var child:DisplayObject;
			i = -1;
			while( ++i < numChildren )
			{
				child = DisplayObject( children[ i ] );
				if (!(child is Civilian))
					continue;
				//only set new depth if necessary
				if( i != getChildIndex( child ) )
				{
					depthsSwapped = true;
					//set their new position
					setChildIndex( child, i );
				}
				
			}
			
			//returns true if 1 or more swaps were made, false otherwise
			return depthsSwapped;
			
		}
		
	}

}