using Godot;
using System;

public partial class MgrPlayer : Node
{
    public override void _Process(double delta)
    {
        // Xキーが押された場合
        if (Input.IsActionPressed("ui_accept"))  // "ui_accept" は Xキーにマッピングされていると仮定
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

        // ようじをシーンに追加
        GetParent().AddChild(player);
    }
}
