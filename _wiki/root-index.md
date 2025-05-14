---
layout  : wikiindex
title   : wiki
toc     : true
public  : true
comment : false
resource: 06/227923-8E1A-42ED-BD8B-7B8C4E1E70EE
updated : 2025-05-14 15:49:18 +0900
regenerate: true
---
* TOC
{:toc}

## [[/blog]]
- [[/blog/2025-05-05-teddynotelab]]
- [[/blog/2025-05-12-catastrophic_forgetting]]

## [[/article]]
- [[/article/react_with_langchain]]
- [[/article/docling]]

## [[/books]]
- [[/books/understanding_deep_learning]]

## [[/study]]

### [[/study/understanding_deep_learning]]
- [[/study/understnading_deep_learning/ch1_introduction]]


## [[/how]]
- [[/how/my-first-wiki]]


## 미분류
- [[pipreqs]]
- [[pandas_interpolation]]

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

