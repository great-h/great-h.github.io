---
layout: default
title: 'ルール - すごい広島'
---

# ルール

すごい広島の参加ルールをもう少し詳しく書きます。

## 基本

* お店に迷惑を掛けない
* 退出自由
* エア参加可能
* やることを宣言する
* blog 記事を書く
* 記事へのリンクを追加する

## やること宣言する

やること宣言には [Github の Issues](https://github.com/great-h/great-h.github.io/issues?state=open) を利用しています。

やることを `issue` として登録します。

### STEP UP

慣れてきたら Issue を作成する際に `label` と `milestone` と `assign` を設定しましょう。

`label` には `やること宣言` というのを用意しているのでこれを利用してください。

`milestone` には 日付を利用しています。参加した日付の `milestone` を設定してください。

`assign` はその `issue` の担当者です。自分を設定しましょう。

## blog 記事を書く

`すごい広島` に参加したら、blog記事を書いてください。

`やること宣言` をしたからには結果を報告する義務があります。
好きなブログサービスで記事を書きましょう。

主なブログサービス

* [Hatena blog](http://hatenablog.com/?locale.lang=ja)
* [Blogger](http://www.blogger.com/start?hl=ja)
* [tumbler](http://www.tumblr.com/)

## 記事へのリンクを追加する

記事を作成したら [すごい広島のサイト](http://great-h.github.io/) へリンクを追加しましょう。

リンクを追加する場所は [_posts](https://github.com/great-h/great-h.github.io/tree/master/_posts) に参加した時のイベントページがあります。
そこに追加することになります。

[サイトのリポジトリ](https://github.com/great-h/great-h.github.io)をクローンして、作業用のブランチを作成します。
ブランチ名は自分のアカウント名などを使用してください。


例:

```
$ git checkout -b アカウント名
```

ブランチを作成したらファイルを編集します。

編集が終了したらコミットをします。

例:

```
$ git commit -m '記事へのリンクを追加'
```

コミットができたら Push をします。

例:


```
$ git push origin アカウント名
```

push をすると Pull Request ができます。Github のページに Pull Request というボタンがあるので、そこから行います。
しばらく待っていれば、誰かが merge してくれて、反映されます。

TODO

### STEP UP

pull request をする前に動作確認をしてみましょう。自分のコンピュータ上でウェブサイトを確認できます。

#### 事前準備

* ruby のインストール
* `bundle install` の実行

### プレビューの方法

* `rake preview` の実行
* [http://localhost:4000/](http://localhost:4000/) にアクセスします。

## おまけ

なれてきたら他の人の Pull Request をレビュー しましょう。

レビューが二つついたら マージをするというルールにしています。
もし、あなたが二人めになったら、マージボタンを押してマージしましょう。
コンフリクトする場合は、Webからはできないので、他の人に任せましょう。
