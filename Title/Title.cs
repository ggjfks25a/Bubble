using Godot;
using System;

//----------------------------------------------------------------------------------------------------
// タイトル画面の管理  
//----------------------------------------------------------------------------------------------------
public partial class Title : Node2D
{
	//--------------------------------------------------------------------------------
	// メンバ変数   
	//--------------------------------------------------------------------------------
	[Export]Node2D   _logo;
	[Export]Sprite2D _fade;
	[Export]Sprite2D _rule;
	double fadeTimer = 2.5;
	bool   isNext    = false;
	
	//--------------------------------------------------------------------------------
	// 初期化処理  
	//--------------------------------------------------------------------------------
	public override void _Ready()
	{
		foreach(Node child in GetTree().Root.GetChildren())
		{
			GD.Print(child.Name);
			if(child.Name == "Bgm")
			{
				foreach(Node n in child.GetChildren())
				{
					if(n is AudioStreamPlayer2D audio)
					{
						audio.Play();
					}
				}
			}
		}
	}

	//--------------------------------------------------------------------------------
	// 更新処理 
	//--------------------------------------------------------------------------------
	public override void _Process(double delta)
	{
		if(isNext)
		{
			fadeTimer += delta;
			if(fadeTimer > 1){ fadeTimer = 1; }

			float alpha = (float)fadeTimer * 2;
			Color color = new Color(0,0,0,alpha);
			_fade.Modulate = color;
			
			if(fadeTimer == 1)
			{
				GoToMain();
				ProcessMode = ProcessModeEnum.Disabled;
			}
		}
		else
		{
			if(fadeTimer > 0)
			{
				fadeTimer -= delta;
				if(fadeTimer < 0){ fadeTimer = 0; }

				float alpha = fadeTimer/2 > 1 ? 1 : (float)fadeTimer/2;
				Color color = new Color(1,1,1,alpha);
				_fade.Modulate = color;
			}	
		}
	}
	
	//--------------------------------------------------------------------------------
	// 入力検知  
	//--------------------------------------------------------------------------------
	public override void _Input(InputEvent @event)
	{	
		if(isNext       ){ return; }
		if(fadeTimer > 0){ return; }
		
		if(@event is InputEventMouseButton mouseEvent && mouseEvent.Pressed)
		{
			if(!_rule.Visible)
			{
				_rule.Visible = true;
			}
			else
			{
				isNext = true;
			}			
		}
	}	
	
	//--------------------------------------------------------------------------------
	// メインシーンへ 
	//--------------------------------------------------------------------------------
	void GoToMain()
	{
		GetTree().ChangeSceneToFile("res://mainScreen.tscn");
	}
}
