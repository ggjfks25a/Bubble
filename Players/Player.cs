using Godot;
using System;

public partial class Player : CharacterBody2D
{
	public const float Speed = 400.0f;

    [Export] public AudioStream setSfx; // Inspector でSEを設定

    public override void _Ready()
    {
        if (setSfx == null)
        {
            GD.PrintErr("setSfx が設定されていません！");
        }
    }

    //プロセスがOnUpdateの役割
    public override void _Process(double delta)
    {
        Position += new Vector2(0, (float)(-Speed * delta)); // 毎フレーム Y 座標を減らして上昇

        // 画面外に出た場合は削除
        if (Position.Y < -360.0f)
        {
            if (setSfx != null)
            {
                MgrSfx.PlaySound(setSfx);
            }
            else
            {
                GD.PrintErr("setSfx が null のため、音が鳴りません！");
            }
            QueueFree();  // 自分自身を削除
        }
    }
}
