using Godot;
using System;

public partial class MgrEsc : Node
{
    private static MgrEsc _instance;

    public override void _Ready()
    {
        if (_instance == null)
        {
            _instance = this;
            SetProcessInput(true); // _Input を有効にする
        }
        else
        {
            QueueFree(); // すでに存在する場合は削除
        }
    }

    public override void _Input(InputEvent @event)
    {
        if (@event is InputEventKey keyEvent && keyEvent.Pressed && keyEvent.Keycode == Key.Escape)
        {
            GetTree().Quit(); // ESCキーでゲーム終了
        }
    }

    public static MgrEsc GetInstance()
    {
        return _instance;
    }
}
