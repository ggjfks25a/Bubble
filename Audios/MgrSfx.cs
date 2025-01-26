using Godot;
using System;

public partial class MgrSfx : AudioStreamPlayer
{
    private static MgrSfx _instance; // シングルトン参照
    private AudioStreamPlayer _mgrSfx;

    public override void _Ready()
    {
        if (_instance == null)
        {
            _instance = this;
            _mgrSfx = new AudioStreamPlayer(); // 明示的にインスタンス化
            AddChild(_mgrSfx);  // これを追加（ノードが存在しない場合、エラーを防ぐ）
        }
        else
        {
            QueueFree(); // 二重にロードされないように削除
        }
    }

    public static void PlaySound(AudioStream sound)
    {
        if (_instance == null)
        {
            GD.PrintErr("SoundManager が初期化されていません！");
            return;
        }
        if (_instance._mgrSfx == null)
        {
            GD.PrintErr("_instance._mgrSfx == null");
            return;
        }
        if (sound == null)
        {
            GD.PrintErr("再生するサウンドが設定されていません！");
            return;
        }

        _instance._mgrSfx.Stream = sound;
        _instance._mgrSfx.Play();
    }
}
