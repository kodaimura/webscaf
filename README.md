# webscaf

Webアプリケーションの雛形を作成できるスキャフォルドツールです。  
ログイン・サインアップ画面をデフォルトで実装しています。

## 対応テンプレート一覧

以下のフレームワーク構成を選択して雛形を作成できます：
| テンプレート構成                         | テンプレート                             |
|----------------------------------------|---------------------------------------------------------------------------------------|
| Gin（Go） + HTML CSS Js                | [Ginテンプレート](https://github.com/kodaimura/scaf-gin)    |
| Gin（Go） + Next.js（TypeScript）      | [GinAPIテンプレート](https://github.com/kodaimura/scaf-gin-api) [Nextテンプレート](https://github.com/kodaimura/scaf-next) |
| Genie（Julia） + HTML CSS Js          | [Genieテンプレート](https://github.com/kodaimura/scaf-genie)   |
| Genie（Julia） + Next.js（TypeScript） | [GenieAPIテンプレート](https://github.com/kodaimura/scaf-genie-api) [Nextテンプレート](https://github.com/kodaimura/scaf-next)  |


## セットアップ手順

1. プロジェクトをクローンします（任意のプロジェクト名で）:

```bash
git clone https://github.com/kodaimura/webscaf.git [project_name]
```

2. クローンしたディレクトリへ移動します：

```bash
cd [project_name]
```

3. セットアップスクリプトに実行権限を付与します：

```bash
chmod +x ./setup.sh
```

4. セットアップスクリプトを実行して雛形を作成します：

```bash
./setup.sh
```

実行後、対話形式でテンプレートの選択を行い、必要な雛形を自動生成します。

## 必要要件

- Git
- Docker
- make
