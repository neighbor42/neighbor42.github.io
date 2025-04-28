---
layout  : wikiindex
title   : wiki
toc     : true
public  : true
comment : false
resource: 06/227923-8E1A-42ED-BD8B-7B8C4E1E70EE
updated : 2025-04-28 10:39:17 +0900
regenerate: true
---
* TOC
{:toc}

## [[/article]]

## [[/how]]


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

