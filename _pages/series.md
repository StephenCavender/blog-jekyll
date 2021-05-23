---
layout: archive
title: Series
permalink: /series
---

<ul>
  {% for series in site.data.series %}
    {% assign series-posts = site.posts | reverse | where: 'series', series.id %}
    {% if series-posts.size > 0 %}
      <li><a href="#{{ series.id}}">{{ series.title}} ({{ series-posts.size }})</a></li>
    {% endif %}
    {% assign series-posts = nil %}
  {% endfor %}
</ul>

{% for series in site.data.series %}
{% assign series-posts = site.posts | reverse | where: 'series', series.id %}
{% if series-posts.size > 0 %}
<h3 id="{{ series.id }}">{{ series.title }}</h3>
<p>{{ series.description }}</p>
<ul>
{% for post in series-posts %}
{% include post-list-item.html %}
{% endfor %}
</ul>
{% endif %}
{% assign series-posts = nil %}
{% endfor %}
