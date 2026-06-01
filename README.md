## TerraformによるAWS環境構築

### 事前準備（Backend S3バケットの作成）
本環境では、Terraformのstateファイルの管理にS3バケットを使用しています。

`terraform init` を実行する前に、あらかじめAWSマネージメントコンソール、またはAWS CLIにて、以下の名前でS3バケットを事前に手動作成しておく必要があります。

- **バケット名**: `raisetech-state-tat`
- **リージョン**: `ap-northeast-1`