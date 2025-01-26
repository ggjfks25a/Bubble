using Godot;
using System;

public partial class Player : CharacterBody2D
{
	public const float Speed = 200.0f;
	public const float JumpVelocity = -400.0f;

    public override void _Ready()
    {
        //var audioPlayer = GetNode<AudioStreamPlayer>("MgrSfx");

        //if (audioPlayer == null)
        //{
        //    GD.PrintErr("MgrSfx ノードが見つかりません");
        //}
        //else
        //{
        //    audioPlayer.Play();
        //}

    }

    //プロセスがOnUpdateの役割
    public override void _Process(double delta)
    {
        Position += new Vector2(0, (float)(-Speed * delta)); // 毎フレーム Y 座標を減らして上昇

        // 画面外に出た場合は削除
        if (Position.Y < -360.0f)
        {
            QueueFree();  // 自分自身を削除
        }
    }
}
