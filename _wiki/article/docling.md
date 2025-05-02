---
layout  : wiki
title   : docling | pdf를 마크다운으로
summary : 
date    : 2025-05-02 10:47:09 +0900
updated : 2025-05-02 12:08:28 +0900
tag     : docling, parser
resource: C1/A38B11-B4A4-454B-926D-48AB14B4DFD7
toc     : true
public  : true
parent  : 
latex   : false
---
* TOC
{:toc}

# Docling
- IBM의 오픈소스 프로젝트
- 다양한 포맷의 문서를 마크다운이나 json으로 변환해 RAG 프레임워크에 임베딩할 수 있음
    - 문맥 인식 기술을 활용해 원본의 내용을 유지할 수 있음
- 개발배경: 다양한 문서 형식을 파싱할 방법을 필요로 하는 요구


## docling 구조
![docling_architecture](https://i.imgur.com/iOHWjBT.png)

예시
1. PDF & 이미지 파싱
2. OCR 객체 인식 기술을 활용해 레이아웃 분석 수행
3. 그런데 어떤 표가 페이지 1과 페이지2에 걸쳐있음
    - 이 표의 구조가 무너지지 않도록 그대로 유지하는 것이 목표
4. 파싱한 정보를 표준화된 docling 포맷으로 조립
5. 이후에 아래의 방식으로 활용 가능
    - json 또는 markdown으로 내보내기
    - 벡터 데이터베이스와 함께 사용할 수 있도록 청킹 처리
    - 문서 기반의 QA 시스템에 활용


## docling 실습

### 기본 사용 예시

```cli
pip install docling  # docling 설치

docling https://arxiv.org/pdf/2206.01062 --output ~/Desktop  # 바탕화면에 변환 결과 저장
```

![doclaynet_paper](https://i.imgur.com/7xOThwP.png)

학술 페이퍼에는 다양한 헤딩, 이미지, 표가 포함되어 있는데 기존 AI 모델이 인식하고 구조화하는데 어려움을 겪는 부분이다.


![docling_result](https://i.imgur.com/DE1vN6i.png)

변환 결과
- 헤더와 텍스트가 원본에서 보았던 대로 잘 포맷됨
- 링크와 폰트 스타일도 적절하게 유지됨
- 이미지는 Base64 인코딩 형식으로 삽입되어 있음
- 표도 깔끔하게 구조화되어 있



```python
from docling.document_converter import DocumentConverter

source = "https://arxiv.org/pdf/2408.09869"  # 문서 로컬 경로  or URL
converter = DocumentConverter()
result = converter.convert(source)
print(result.document.export_to_markdown())
```


## with llamaindex
문서 파싱 + QA 시스템 구축

### 필요 패키지 설치
```python
!pip install -q --progress-bar off llama-index-core llama-index-readers-docling \
llama-index-node-parser-docling llama-index-embeddings-huggingface \
llama-index-llms-huggingface-api llama-index-vector-stores-milvus \
llama-index-readers-file python-dotenv

# import modules
import os
from pathlib import Path
from tempfile import mkdtemp
from warnings import filterwarnings
from dotenv import load_dotenv

load_dotenv()

filterwarnings(action="ignore", category=UserWarning, module="pydantic")
filterwarnings(action="ignore", category=FutureWarning, module="easyocr")

os.environ['TOKENIZERS_PARALLELISM'] = "false"

def _get_env_from_colab_or_os(key):
  return os.getenv(key)
```

### 주요 파라미터 정의
```python
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.llms.huggingface_api import HuggingFaceInferenceAPI

hf_token = os.getenv("HF_TOKEN")

if not hf_token:
  raise EnvironmentError("HF_TOKEN environment variable is not set!")

# embedding and generation models
EMBED_MODEL = HuggingFaceEmbedding(model_name="BAAI/bge-small-en-v1.5")
MILVUS_URI = str(Path(mkdtemp()) / "docling.db")
GEN_MODEL = HuggingFaceInferenceAPI(
    token=hf_token,
    model_name="mistralai/Mixtral-8x7B-Instruct-v0.1",
)

SOURCE = "https://arxiv.org/pdf/2408.09869"  # docilng tech report
QUERY = "Which are the main AI models in Docling?"

embed_dim = len(EMBED_MODEL.get_text_embedding("hi"))
```

- 허깅페이스 토크나이저 임포트
- 모델 2개 사용
    - 임베딩 모델(bge-small-en-v1.5): 문서를 노드로 변환한 뒤 벡터 데이터베이스에서 응답을 생성할 수 있도록 함
    - 생성형 AI 모델(Mixtral): 사용자 질의에 대해 자연어로 된 응답 생성


### RAG 파이프라인
```python
# RAG pipline w Docling
from llama_index.core import StorageContext, VectorStoreIndex
from llama_index.core.node_parser import MarkdownNodeParser
from llama_index.readers.docling import DoclingReader
from llama_index.vector_stores.milvus import MilvusVectorStore

# DoclingReader & node parser 정의
reader = DoclingReader()
node_parser = MarkdownNodeParser()

# 벡터 스토어 구성
vector_store = MilvusVectorStore(
    uri=str(Path(mkdtemp()) / "docling.db"),
    dim=embed_dim,
    overwrite=True,
)

# 인덱스 생성하기
index = VectorStoreIndex.from_documents(
    documents=reader.load_data(SOURCE),
    transformations=[node_parser],
    storage_context=StorageContext.from_defaults(vector_store=vector_store),
    embed_model=EMBED_MODEL,
)
```
- 문서 처리
- 구조화된 텍스트 추출
- 노드(nodes) 형태로 분할해 변환

이 때 사용되는 리더는 입력 문서를 변확하기 위한 것이고, <br>
함께 사용하는 노드 파서는 문서를 논리적으로 분할해 질문 시 섹션별 응답이 가능하도록 해준다. <br>
"Docing이 사용하는 주요 AI 모델은 무엇인가요?" 라는 질문에, 이 노드 ㅈ구조 덕분에 **문맥 단위의 정확한 응답**이 가능해진다.

**Vector store**
- 문서 내용을 벡터로 임베딩한 후 유사도 기반 검색을 수행
- 인덱스 생성
    - 이 인덱스를 통해 문서를 정렬하고 파악 가능

입력한 문서를 
- 노드로 분할하고
- 임베딩 해서
- 벡터 DB에 저장한다

이 과정을 마치면, RAG 시스템에서 질문에 대한 정확한 응답을 도출할 수 있게 되는 것이다.

### 결과
```python
# 파이프라인에 질의
result = index.as_query_engine(llm=GEN_MODEL).query(QUERY)

# 결과 출력
print(f"Q: {QUERY}\nA: {result.response.strip()}\n\nSources:")
for node in result.source_nodes:
  print(f"Text: {node.text}\nMetadata: {node.metadata}\n")
```

#### 질문: Docling이 사용하는 주요 AI 모델은?
1. 질문과 유사한 내용을 가진 문서 노드들이 임베딩된 문서를 기준으로 검색
2. 검색된 문서 노드를 기반으로 mistral 모델이 응답 생성
3. 응답 + 출처도 함께 제공
    - Docling은 DoclingNet과 TableFormer, 두 가지 모델을 기반으로 작동한다

```CLI
# 출력된 응답
Q: Which are the main AI models in Docling?
A: The two main AI models in Docling are a layout analysis model, which is an accurate object-detector for page elements, and TableFormer, a state-of-the-art table structure recognition model.

Sources:
Text: ## 3.2 AI models

As part of Docling, we initially release two highly capable AI models to the open-source community, which have been developed and published recently by our team. The first model is a layout analysis model, an accurate object-detector for page elements [13]. The second model is TableFormer [12, 9], a state-of-the-art table structure recognition model. We provide the pre-trained weights (hosted on huggingface) and a separate package for the inference code as docling-ibm-models . Both models are also powering the open-access deepsearch-experience, our cloud-native service for knowledge exploration tasks.
Metadata: {'header_path': '/'}

Text: ## 5 Applications

Thanks to the high-quality, richly structured document conversion achieved by Docling, its output qualifies for numerous downstream applications. For example, Docling can provide a base for detailed enterprise document search, passage retrieval or classification use-cases, or support knowledge extraction pipelines, allowing specific treatment of different structures in the document, such as tables, figures, section structure or references. For popular generative AI application patterns, such as retrieval-augmented generation (RAG), we provide quackling , an open-source package which capitalizes on Docling's feature-rich document output to enable document-native optimized vector embedding and chunking. It plugs in seamlessly with LLM frameworks such as LlamaIndex [8]. Since Docling is fast, stable and cheap to run, it also makes for an excellent choice to build document-derived datasets. With its powerful table structure recognition, it provides significant benefit to automated knowledge-base construction [11, 10]. Docling is also integrated within the open IBM data prep kit [6], which implements scalable data transforms to build large-scale multi-modal training datasets.
Metadata: {'header_path': '/'}

```










