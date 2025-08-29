# [WIP] PVEノードの自動セットアップ

管理用PCにAnsibleをインストールします．

```shell
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

タスク実行に必要なパッケージをインストールします．

```shell
sudo apt install python3-proxmoxer python3-requests
ansible-galaxy collection install community.proxmox
```

PVEノードの初期セットアップをしましょう．
管理用PCで以下のコマンドを実行します．

```shell
ansible-playbook -i production site.yml
```

これで，PVEクラスタを組むことができました．
（実行直後はPVEノードにアクセスできないことがあります．）

> [!NOTE]
> 管理ノードにSSH接続をしたことがない場合，以下の警告が出力され処理が中断されます．
> ```
> hikari | FAILED | rc=-1 >>
> Using a SSH password instead of a key is not possible because Host Key checking is enabled and sshpass does not support this.  Please add this host's fingerprint to your known_hosts file to manage this host.
> ```
> 対応としては，
> 1. 手動でSSH接続し，known_hostsにfingerprintを記録する
> 2. 以下の内容の，`/etc/ansible/ansible.cfg`または`~/.ansible.cfg`を作成する[^1]
> ```toml
> [defaults]
> host_key_checking = False
> ```
> などがあります．
> 
> セキュリティ的には対応1を取りたいですが，管理ノードが多い場合や試験的に運用する場合は対応2も有用でしょう．
> 
> [^1]: [Connection methods and details — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/inventory_guide/connection_details.html#managing-host-key-checking)

## 参考文献

- [Ansible Documentation — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/index.html)
- [Ansible の使い方](https://zenn.dev/y_mrok/books/ansible-no-tsukaikata)
- [community.proxmox.proxmox_cluster module – Create and join Proxmox VE clusters — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/community/proxmox/proxmox_cluster_module.html)
- [community.proxmox.proxmox_cluster_join_info module – Retrieve the join information of the Proxmox VE cluster — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/community/proxmox/proxmox_cluster_join_info_module.html)
