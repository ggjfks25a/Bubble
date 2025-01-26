using Godot;
using System;

//----------------------------------------------------------------------------------------------------
// メインゲームの流れを管理するやつ  
//----------------------------------------------------------------------------------------------------
public partial class MainGameManager : Node
{
	[Export]Sprite2D _fade;		// フェードパネル 
	[Export]Node2D[] _bgLogo;	// 背景を流れるロゴ 
	double fadeTimer = 0.5;
	
	//--------------------------------------------------------------------------------
	// 初期化 
	//--------------------------------------------------------------------------------
	public override void _Ready()
	{
			
	}

	//--------------------------------------------------------------------------------
	// 更新 
	//--------------------------------------------------------------------------------
	public override void _Process(double delta)
	{
		// フェードイン処理 
		if(fadeTimer > 0)
		{
			fadeTimer -= delta;
			if(fadeTimer < 0){ fadeTimer = 0; }

			float alpha = (float)fadeTimer * 2;
			Color color = new Color(0,0,0,alpha);
			_fade.Modulate = color;
		}	
		
		// 背景スクロール 
		for(int i=0; i<_bgLogo.Length; i++)
		{
			float speed = 128 * (float)delta;
			_bgLogo[i].Position += new Vector2(speed, -speed);
			
			Vector2 pos = _bgLogo[i].Position;
			if(pos.X > 1144)
			{
				pos.X = -1144;
			}
			if(pos.Y < -648)
			{
				pos.Y = 648;
			}
			_bgLogo[i].Position = pos;
			
			GD.Print(_bgLogo[i].Position );
		}
	}
}
