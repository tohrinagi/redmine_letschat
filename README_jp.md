# Let's Chat Plugin for Redmine

## 概要

Redmine のチケットを作成した時 [Let's Chat](http://sdelements.github.io/lets-chat/) に通知するプラグインです。

## インストール

### 1. プラグインを git clone で redmine の plugins ディレクトリに展開します。
```
~$ cd /var/lib/redmine/plugins
plugins$ git clone https://github.com/tohrinagi/redmine_letschat.git

```
### 2. Redmine へ管理者権限でログインし、プラグインの設定を行います。

Redmine のプラグイン設定のページへいき、Redmine Let's Chat プラグインの設定を行います。

|設定項目名|設定するもの|
|---|---|
|LetsChat URL|通知する Let's Chat の URL を入力します|
|LetsChat Room|通知する Let's Chat の ルームIDを入力します（ルームIDは、Let's Chat の URL の後ろにあるハッシュ値です）|
|LetsChat Token|通知する Let's Chat のアカウントの API Token を入力します|


## 使い方

チケットを新規作成したり編集したりすると、自動的に Let's Chat へ通知されます。

