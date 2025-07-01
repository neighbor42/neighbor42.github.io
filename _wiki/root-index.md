---
layout  : wikiindex
title   : wiki
toc     : true
public  : true
comment : false
resource: 06/227923-8E1A-42ED-BD8B-7B8C4E1E70EE
updated : 2025-07-01 15:23:44 +0900
regenerate: true
---
* TOC
{:toc}


## [[/article]]
- [[/article/react_with_langchain]]
- [[/article/docling]]

## [[/books]]
- [[/books/understanding_deep_learning]]

## [[/study]]
- [[/study/understanding_dl_notation]]

### [[/study/understanding_deep_learning]]
- [[/study/understanding_deep_learning/ch1_introduction]]
- [[/study/understanding_deep_learning/ch2_supervised_learning]]
- [[/study/understanding_deep_learning/ch3_shallow_neural_networks]]
- [[/study/understanding_deep_learning/ch4_deep_neural_networks]]
- [[/study/understanding_deep_learning/ch5_loss_function]]
- [[/study/understanding_deep_learning/ch6_fitting_model]]
- [[/study/understanding_deep_learning/ch7_gradients]]
- [[/study/understanding_deep_learning/ch8_measuring_performance]]
- [[/study/understanding_deep_learning/ch9_regularization]]
- [[/study/understanding_deep_learning/ch10_cnn]]
- [[/study/understanding_deep_learning/ch11_resnet]]
- [[/study/understanding_deep_learning/ch12_transformers]]
- [[/study/understanding_deep_learning/ch13_gnn]]

## [[/dsa]]
- [[/dsa/arrays_and_strings]]

## [[/obsidian]]
- [[/obsidian/obsidian_setup1]]

## [[/how]]
- [[/how/my-first-wiki]]
- [[/how/vimwiki_design]]

## [[/incident_archive]]
- [[/incident_archive/unicode_error_handling]]
- [[/incident_archive/tiktoken_cache_http_error]]

## [[/lifehacks]]
- [[/lifehacks/semas_kyobo]]

## 미분류
- [[pipreqs]]
- [[pandas_interpolation]]
- [[vllm_serve]]


## [[/blog]]
- [[/blog/2025-05-05-teddynotelab]]
- [[/blog/2025-05-12-catastrophic_forgetting]]
- [[/blog/2025-06-12-multi_llm_api]]

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

