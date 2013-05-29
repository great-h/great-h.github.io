---
layout: default
title: 'すごい広島'
---

<div id="home">

  <h1>すごい広島とは</h1>

  <p>広島のエンジニアやウェブデザイナーが毎週集まって、
    もくもくしたり Hackしたり 読書したり する場所です。</p>

 <ul class="posts">
   活動履歴
   {% for post in site.posts %}
     <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
   {% endfor %}
  </ul>

</div>
