# home-cloud

おうちクラウドの設定ファイル集

- [Proxmox VE の自動インストール](./proxmox-auto-install/)
- [PVEノードの自動セットアップ](./ansible/)

## 構成

![](./diagrams/home-infra.drawio.svg)

### ネットワーク構成

- YAMAHA RTX1200
  - ルータ
  - 各ネットワークの疎通要件を設定
  - DHCPサーバ稼働
  - ポートVLANを設定
    - タグVLAN1本にすると帯域が確保できないため
    - RTX1200はLAG（リンクアグリゲーション）できないため

- Allied Telesis AT-x510-28GTX
  - 各ネットワークのポートVLANを設定
  - PVEノード`nonoka`と10G通信をする（一番のキモ）
    - 対向がいないのであまり恩恵を感じていない
    - 10G喋れるノードを増やしたい気持ち

---

- `192.168.10.0/24`： 管理用ネットワーク
  - `192.168.20.0/24`，`192.168.30.0/24`，`192.168.40.0/24`に疎通できる
  - 上記のネットワークや，他のネットワークからはアクセスできない
  - 遠隔で操作できるようにするため，インターネットにも接続できるようにしている
  - 極力使いたくない気持ち

- `192.168.20.0/24`： プライベート用ネットワーク
  - 一般向け

- `192.168.30.0/24`： 技術検証用ネットワーク
  - PVEクラスタなどを所属させる

- `192.168.40.0/24`： IoT機器用ネットワーク
  - 未使用
  - APを生やしたいが，プライベート用ネットワークに使ってる1台しかない

### ハードウェア構成

|名前|モデル|プロセッサ|メモリ|内蔵ストレージ|
|-|-|-|-|-|
|hikari|GMKtec NucBox G3 Plus|Intel Processor N150|TWSC SODIMM DDR4-3200 8GB x1|TWSC M.2 NVMe SSD 256GB x1|
|tairitsu|GMKtec NucBox G3 Plus|Intel Processor N150|TWSC SODIMM DDR4-3200 8GB x1|TWSC M.2 NVMe SSD 256GB x1|
|nonoka|Fujitsu PRIMERGY TX1320 M3|Intel Xeon E3-1230 v6|Samsung DIMM DDR4-2400 8GB x2|Seagate SAS 300GB x2 + PRAID CP400i|

### ソフトウェア構成

#### Proxmox VE クラスタ

|ノード名|FQDN|IPアドレス|
|-|-|-|
|hikari|hikari.home-cloud.internal|192.168.30.2/24|
|tairitsu|tairitsu.home-cloud.internal|192.168.30.3/24|
|nonoka|nonoka.home-cloud.internal|192.168.30.4/24|
