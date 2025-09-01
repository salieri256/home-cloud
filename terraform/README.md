# Terraformを使ってProxmox上にLinuxコンテナを立てる

筆者はWindows 11ユーザなので，WSL2上で作業していきます．

## ホストPCにTerraformをインストールする

管理用PCにtfenvとterraformをインストールします．
tfenvによって，プロジェクト内のterraformのバージョン指定に対応できるようにします．

```shell
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

```shell
tfenv install latest
tfenv use latest
```

## プロジェクトの初期化

各々，最初に1回実行すればOK．

```shell
terraform init
```

## 実行計画の確認

```shell
terraform plan
```

## コードの適用

```shell
terraform apply
```

## 参考文献

- [Proxmox VEサーバー仮想化 導入実践ガイド　エンタープライズシステムをOSSベースで構築 impress top gearシリーズ](https://book.impress.co.jp/books/1124101030)
- [proxmox_lxc | Resources | Telmate/proxmox | Terraform | Terraform Registry](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/lxc)
