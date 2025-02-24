using Godot;
using System;

public partial class MgrPlayer : Node
{
    //音を鳴らす関数を作る

    [Export] public AudioStream setSfx; // Inspector でSEを設定

    public override void _Process(double delta)
    {
        // スペースが押された場合
        if (Input.IsActionJustPressed("ui_accept"))  // "ui_accept"はスペース
        {
            ShootYouzhi();

        }
    }

    [Export] private PackedScene playerScene;

    // 弾を発射するメソッド
    private void ShootYouzhi()
    {
        if (playerScene == null)
        {
            GD.Print("Player scene is not set!");
            return;
        }

        // Player ノードをインスタンス化
        CharacterBody2D player = (CharacterBody2D)playerScene.Instantiate();

        // ようじの位置を設定（画面下から発射）
        player.Position = new Vector2(0.0f, 360.0f);
        player.Scale = new Vector2(0.25f, 0.25f);

        MgrSfx.PlaySound(setSfx);

        // ようじをシーンに追加
        GetParent().AddChild(player);
    }
}
