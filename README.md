[![Dependency Status](https://gemnasium.com/great-h/great-h.github.io.png)](https://gemnasium.com/great-h/great-h.github.io)

# すごい広島 [http://great-h.github.io/](http://great-h.github.io/)

## ローカル確認環境の構築

### CentOS 6系

※この方法ではシステムにRVMを使ってRubyをインストールします

1. 実行ユーザの作成

  ```
  $ su -
  # useradd greathuser
  ```
  ※必要であればgreathuserユーザのパスワードを設定する
  ```
  # passwd greathuser
  ```

1. RVMをgreathuserで使えるようにする

  ```
  # groupadd rvm
  # usermod -a -G rvm root
  # gpasswd -a greathuser rvm
  ```

1. RVMのインストール

  ```
  # bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
  ```

1. RVMでRuby 2.0.0をインストール

  ```
  # source /etc/profile.d/rvm.sh
  # rvm install 2.0.0
  # rvm use 2.0.0 --default
  ```

1. 今後.rvmrcが設置されたフォルダでは設定を自動で許可する設定

  ```
  # vi /etc/rvmrc
  ```
  で、/etc/rvmrcファイルを開き、下記の内容を追記する
  ```
  rvm_trust_rvmrcs_flag=1
  ```

1. bundlerをインストール・・・しない

  ここでbundlerと呼ばれるrubyのパッケージの依存関係を解決するパッケージをインストールしたいところですが、RVMでRubyをインストールした場合はすでに入っているようなので、gem install bundlerはしません。

  ※補足<br>
  rbenvやソースコードからrubyをインストールした場合は`gem install bundler`してください。

1. epelリポジトリを無効化する（したい場合は）

  `rvm install 2.0.0`の際にlibyaml-develパッケージのインストールがされますが、このときにlibyaml-develのパッケージリポジトリであるepelリポジトリがyumに登録され有効化されているので無効化して他のパッケージに影響を与えないようにします。
  ```
  # vi /etc/yum.repos.d/epel.repo
  ```
  で、/etc/yum.repos.d/epel.repoファイルを開き、`enabled=1`を`enabled=0`に変更します。

1. great-hからソースをクローンしてbundle installをする

  ```
  # su - greathuser
  $ git clone git@github.com:great-h/great-h.github.io.git
  $ cd great-h.github.io
  $ bundle install
  ```
  ※`git clone git@github.com:great-h/great-h.github.io.git`の箇所はリポジトリをフォークした場合はそのリポジトリに変更してください。

1. 実行

  ```
  $ bundle exec rake preview
  ```

1. ブラウザで確認

  `http://&lt;hostname or IP address&gt;:4000/`をブラウザで開いて確認する<br>
  ※環境(GUI環境がある環境)によっては`bundle exec rake preview`時にブラウザを起動して開いてくれます。

## 新しいイベントページの生成方法

新しいイベントページ`_posts/yyyy-mm-dd-event-xxx.markdown`の生成方法
```
$ bundle exec rake new_event
```
