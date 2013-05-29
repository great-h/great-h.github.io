---
layout: default
title: 'すごい広島'
---

# すごい広島とは

広島のエンジニアやウェブデザイナーが毎週集まって、
もくもくしたり Hackしたり 読書したり する場所です。

## 場所/時間

* 毎週水曜日 19:00 - 21:50 ぐらいに開催
* [タリーズコーヒー 広島本通り店 （広島県広島市中区本通5-5）](http://as.chizumaru.com/tullys/detailMap?account=tullys&accmd=0&adr=34101&c21=1&bid=91&pgret=2) (これは仮の場所です。もっといい場所を探しています)
* エア参加可能 (ルールを参照してください)

## ルール(概要)

* お店に迷惑を掛けない
* 退出自由
* すごい広島でやることを [Github の Issues](https://github.com/great-h/great-h.github.io/issues?state=open) で宣言する
* イベント終了後に blog 記事を書いて、その日のイベントページにプルリクエストを送る
* エア参加可能です

このルールは **MUST** ではありませんが**気持ち MUST**でお願いします。

Github の利用方法がわからない場合は、他の参加者に気軽に聞いてください。

まだ、blogをもっていない場合は、`blog を作成する。` などのタスクを作成して参加してみるのも良いです。

あとは、参加者と自由に情報交換したり、作業に没頭したりしましょう。

## 活動履歴

<ul class="posts">
{% for post in site.posts %}
<li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
</ul>
