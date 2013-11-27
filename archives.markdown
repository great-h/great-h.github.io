---
layout: default
title: '活動履歴 - すごい広島'
---

# これまでの活動

<ul class="posts">
{% for post in site.posts reversed %}
<li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
</ul>
