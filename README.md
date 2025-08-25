# home-cloud

おうちクラウドの設定ファイル集

- [Proxmox VE の自動インストール](./proxmox-auto-install/)

## 備考

### ハードウェア構成

|名前|モデル|プロセッサ|メモリ|内蔵ストレージ|
|-|-|-|-|-|
|hikari|GMKtec NucBox G3 Plus|Intel Processor N150|TWSC SODIMM DDR4-3200 8GB x1|TWSC M.2 NVMe SSD 256GB x1|
|tairitsu|GMKtec NucBox G3 Plus|Intel Processor N150|TWSC SODIMM DDR4-3200 8GB x1|TWSC M.2 NVMe SSD 256GB x1|
|nonoka|Fujitsu PRIMERGY TX1320 M3|Intel Xeon E3-1230 v6|Samsung DIMM DDR4-2400 8GB x2|Seagate SAS 300GB x2 + PRAID CP400i|

### ソフトウェア構成

#### Proxmox VE クラスタ

|FQDN|IPアドレス|
|-|-|
|hikari.home-cloud.internal|192.168.30.2/24|
|tairitsu.home-cloud.internal|192.168.30.3/24|
|nonoka.home-cloud.internal|192.168.30.4/24|
