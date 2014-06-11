package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	private var text:FlxText;
	private var shadow:FlxText;
	private var shakeAmount:Float = 0;
	private var letterPos:Int = 0;
	
	inline static public function LETTERS():Array<String> {
		return ["FLAPPYBALT HD", "100+ PLAYERS", "PC MAC LINUX", "FREE", "ON STEAM GREENLIGHT"];
	}
	
	inline static public var INCREMENT:Int = 16;
	inline static public var SHAKE_INCREASE:Float = 0.001;
	
	override public function create():Void
	{
		super.create();
		
		FlxG.camera.bgColor = FlxColor.BLACK;
		FlxG.mouse.visible = false;
		
		shadow = new FlxText(0, 0, FlxG.width, LETTERS()[letterPos], 16);
		shadow.color = 0xffCCCCCC;
		shadow.alignment = "center";
		add(shadow);
		
		text = new FlxText(0, 0, FlxG.width, LETTERS()[letterPos], 16);
		text.alignment = "center";
		add(text);
		
		FlxSpriteUtil.screenCenter(text);
		shadow.y = text.y + 1;
		
		shakeMore();
	}

	override public function update():Void
	{
		super.update();
		
		if (FlxG.keys.justPressed.RIGHT)
		{
			letterPos++;
			letterPos = Std.int(FlxMath.bound(letterPos, 0, LETTERS().length - 1));
			text.text = LETTERS()[letterPos];
			FlxSpriteUtil.screenCenter(text);
			text.size += INCREMENT;
			
			shadow.text = text.text;
			shadow.size = text.size;
			shadow.y = text.y + 1;
			
			shakeMore();
		}
	}
	
	private function shakeMore():Void
	{
		shakeAmount += SHAKE_INCREASE;
		FlxG.camera.shake(shakeAmount, FlxMath.MAX_VALUE_INT);
	}
}