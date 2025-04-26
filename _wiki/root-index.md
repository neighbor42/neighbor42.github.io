---
layout  : wikiindex
title   : wiki
toc     : true
public  : true
comment : false
updated : 2025-04-26 13:00:12 +0900
regenerate: true
---

## [[how-to]]

* [[mathjax-latex]]

## [[articles/]]
- [[ReAct]]
- [[weeknd]]
- [[chmod]]

[[/mkdir]]
[[what/]]

[[/yes]]


[[test]]

---

## blog posts
<div>
    <ul>
{% for post in site.posts %}
    {% if post.public == true %}
        <li>
            <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">
                {{ post.title }}
            </a>
        </li>
    {% endif %}
{% endfor %}
    </ul>
</div>

