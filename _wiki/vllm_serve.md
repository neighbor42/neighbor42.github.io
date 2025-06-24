---
layout  : wiki
title   : vllm으로 Qwen3 서빙하기
summary : 
date    : 2025-06-24 10:52:01 +0900
updated : 2025-06-24 13:17:26 +0900
tag     : vllm local llm
toc     : true
public  : true
parent  : [[index]]
latex   : false
resource: FE3D6A6D-588C-C0CE-671D-4B1F6F1645DF
---
* TOC
{:toc}

## What
- 모델 배포 과정을 간소화하는 오픈 소스 도구
	- 기존 모델 배포 과정은 복잡하고 비용이 많이 듬
- PageAttention: 효율적인 LLM 메모리 관리
- Hugging Face 호환: pre-trained model or 미세조정(finetuned models) 모델 쉽게 활용 가능
- 거의 모든 오픈 소스 모델 지원

## vllm으로 모델 서빙과 배포
```python
!pip install vllm
!pip install -U "huggingface_hub[cli]"
!pip install langchain-openai
```

```
!nohup vllm serve Qwen/Qwen3-8B --dtype auto --api-key token-abc123 &

from openai import OpenAI

api_key = "token-abc123
api_base = "http://localhost:8000/v1"

langchain_model = ChatOpenAI(
	api_key=api_key,
	base_url=api_base,
	model="Qwen3-8B",
	temperature=0,
	streaming=True,
)
```




## Resources
- [vllm official doc](https://docs.vllm.ai/en/latest/)
