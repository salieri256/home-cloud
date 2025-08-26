# Proxmox VEの自動インストール

Proxmox VEには自動インストール機能があります．
インストーラと対話して手動で設定をするアレを，応答ファイルによって自動化できます．

筆者はWindows 11ユーザなので，WSL2上で作業していきます．

## Proxmox VEインストーラのダウンロード

ここでは`Proxmox VE 9.0 ISO Installer`を使用します．

```shell
wget -P images https://enterprise.proxmox.com/iso/proxmox-ve_9.0-1.iso
```

[ここ](https://www.proxmox.com/en/downloads/proxmox-virtual-environment/iso)からもダウンロードできます．

## 自動インストール用ISOイメージの作成

ISO作成ツールとして`proxmox-auto-install-assistant`を使用します．
権限がないよ！と言われたりしたら，適宜`sudo`してください．

```shell
apt update
apt install -y wget xorriso
wget http://download.proxmox.com/debian/pve/dists/bookworm/pve-no-subscription/binary-amd64/proxmox-auto-install-assistant_8.4.6_amd64.deb -O proxmox-auto-install-assistant.deb
dpkg -i proxmox-auto-install-assistant.deb
```

Dockerが使える方は，以下のコマンドでも同じことができます．

```shell
docker build -t proxmox-auto-install .
docker run --rm -it -v ./:/workspace proxmox-auto-install
```

---

各PVEノードISOイメージを作成します．

```shell
proxmox-auto-install-assistant prepare-iso images/proxmox-ve_9.0-1.iso --fetch-from iso --answer-file answers/hikari-answer.toml --output dist/hikari-pve_9.0-1.iso
proxmox-auto-install-assistant prepare-iso images/proxmox-ve_9.0-1.iso --fetch-from iso --answer-file answers/tairitsu-answer.toml --output dist/tairitsu-pve_9.0-1.iso
proxmox-auto-install-assistant prepare-iso images/proxmox-ve_9.0-1.iso --fetch-from iso --answer-file answers/nonoka-answer.toml --output dist/nonoka-pve_9.0-1.iso
```

### Linuxカーネルパラメータを編集する場合

Linuxカーネルパラメータを編集する必要がある場合は，もうひと手間必要です．
ここではPVEノード`nonoka`用に設定を変更します．
`nonoka`が搭載しているハードウェアRAID`PRAID CP400i`を使用するには，PCIパススルーを設定する必要があるからです．

ISOイメージをマウントしても読み取り専用になってしまうので，中身を別のイメージにコピーしてそれを編集することにします．
まず，空のイメージを作成し，`/media/writable`にマウントします．

```shell
dd if=/dev/zero of=~/writable.img bs=10M count=1024
mkfs.ext4 ~/writable.img
sudo mkdir /media/writable
sudo mount -o loop ~/writable.img /media/writable
```

ISOイメージも`/media/iso`にマウントします．中身を`/media/writable`にコピーしておきます．

```shell
sudo mkdir /media/iso
sudo mount -o loop dist/nonoka-pve_9.0-1.iso /media/iso
sudo cp -r /media/iso/* /media/writable/
```

さて，Linuxカーネルパラメータを編集していきましょう．
`/media/writable/boot/grub/grub.cfg`をエディタで開きます．
パーミッションが`-r--r--r--`になっているので，書き込み権限を与えておきます．

```shell
sudo chmod +w /media/writable/boot/grub/grub.cfg
sudo nano /media/writable/boot/grub/grub.cfg
```

`/media/writable/boot/grub/grub.cfg`の52行目に，`linux`から始まる項目があります．
この末尾に`intel_iommu=on iommu=pt`を追加してあげます．
下にも似たような記述がありますが，こちらは自動インストール時には適用されないのでお間違えの無いよう．

![](./docs/grub-before.png)

![](./docs/grub-after.png)

編集は以上です．あと一息です．

編集済みの内容から，再びISOイメージを作成します．
`mkisofs`コマンドを使いましょう．

```shell
sudo apt install mkisofs
mkisofs -o nonoka-pve_9.0-1-edited.iso /media/writable
```

これで，Linuxカーネルパラメータを編集した`nonoka-pve_9.0-1-edited.iso`が完成しました．

## インストールメディアの作成

ここでは`rufus-4.9p`を使用します．
rufusは[ここ](https://rufus.ie/ja/)からダウンロードできます．

先程作成ISOイメージを選択します．

![](./docs/rufus.png)

WSL2上で作業した方は，エクスプローラからWSL2にアクセスしてください．
アドレスバーに`\\wsl$`を入力するといいかもしれません．

スタートを押すと，インストールメディアの作成が始まります．

## 参考文献

- [Automated Installation - Proxmox VE](https://pve.proxmox.com/wiki/Automated_Installation)
