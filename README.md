# BCDiceCord

Discordでどどんとふと同じような感じでダイスロールができます

- [どどんとふ](http://www.dodontof.com/)
    - [Bone & Cards](https://github.com/torgtaitai/BCDice) (どどんとふのダイスボット)
- [Discord](https://discordapp.com/)
    - [discordrb](https://github.com/meew0/discordrb)

素晴らしいサービスとライブラリを無料で自由に使えるようにしてくださった方々、ありがとうございます。

## 必要環境
- Ruby2.1以上
- bundler

## 使い方
まず、
```
git submodule init
git submodule sync
git submodule update
```
を実行して、Bone&Cardsをダウンロードします。

次に、`bundle install`を実行して必要ライブラリをインストール。

最後にbcdicecord.rbと同じフォルダにtoken.txtというファイルを用意して、1行目にダイスボットのクライアントID、
2行目にトークンを書き込みます

`ruby bcdicecord.rb`でダイスボットが動き始めますので、セッションしたいサーバ/チャンネルにボットを招待して楽しみましょう。

エラーメッセージ等が出る場合はクライアントIDたトークンが間違ってる可能性があります。

## コマンド一覧

### helloコマンド
`こんにちわ`と送信すると、
```
Userさん、こんにちわ
```
と返してくれます。

ボットがちゃんと動いてるかどうかの確認にお使いください。

### systemlistコマンド
`!systemlist`と送信すると、現在の環境で使用可能なTPRGシステムの一覧がプライベートメッセージで送られてきます。

### setコマンド
`set:system`と送信すると、そのサーバにおいてのTRPGシステムがsystemで登録されます。

つまり、クトゥルフで遊びたい場合は
```
set:クトゥルフ
set:Cthuluhu
```
と送信すると、そのサーバ内でクトゥルフのダイスボットが使えます。

システムの名称は`!systemlist`コマンドで出てきたものが使えます。
また、日本語(一部韓国語)でもアルファベットでもどちらでも認識します。

### systemhelpコマンド
`!systemhelp`と送信すると、現在登録されているシステムのダイスコマンドのヘルプをプライベートメッセージで送ってくれます。

### systemコマンド
`system`と送信すると、現在登録しているシステムを送信してくれます。

```
set:KanColle
> User:ゲームが艦これRPGにセットされました
system
> 艦これRPG
```

### ダイスロールコマンド
どどんとふのコマンドがそのまま使えます。

また、秘匿ロールも使用可能です。
プライベートメッセージでダイスロールを行ってくれます。
(注意:ボットにプライベートメッセージでダイスコマンドを送信しても、何も反応しません)
