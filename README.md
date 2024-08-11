# AmneziaWG kernel module build tool for OpenWrt devices
Description only in russian
## Как собрать?
Для сборки своего модуля и luci-плагина, необходимо сделать форк данного репо в свой проект. 
### Как настроить?
В форке нужно настроить Actions workflow main.yml (.github/workflows/main.yml) на билд модуля под свой девайс, 
указав четыре параметра в секции *jobs.build.strategy.matrix.build_env*:
- tag: версия OpenWrt
- target: таргет устройства для сборки модуля
- subtarget: сабтаргет устройства для сборки модуля
- vermagic: меджик-версия ядра для сборки модуля
- pkgarch: архитектура процессора для сборки пакетов\

Target и subtarget можно взять со страницы загрузки устройств <https://firmware-selector.openwrt.org>, в найденном устройстве в секции __About this build__:\
``
Platform ramips/mt7621
``\
здесь target -- ramips, subtarget -- mt7621.\
Чтобы найти pkgarch и vermagic, можно воспользоваться скриптом из проекта ``tool/detect-device.sh``, указав в нем переменные target, subtarget и tag.
Итого, в main.yml секция *jobs.build.strategy.matrix.build_env* должна выглядеть следующим образом:
```yml
jobs:
  build:
    name: "v${{ matrix.build_env.tag }} - ${{ matrix.build_env.pkgarch}} :: ${{ matrix.build_env.target}}/${{ matrix.build_env.subtarget}} build"
    runs-on: ubuntu-latest
    strategy:
      matrix:
        build_env:
          - tag: "23.05.4"
            pkgarch: mipsel_24kc
            target: ramips
            subtarget: mt7621
            vermagic: "144de9e5c1a8813b724b14faa054d9f0"
```
### Как собрать
1. После сделанных изменений и коммита нужно включить в проекте workflow main.yml (по-умолчанию он отключен)
2. Сделать тэг коммита (формат vX.Y.Z) и пуш тэга  - ``git tag v0.1.2 && git push origin v0.1.2``
3. Билд запустится автоматически (сборка идет около двух часов)

После удачной сборки в проекте появится релиз версии vX.Y.Z с тремя пакетами: модуль ядра, тул и плагин для luci. Их нужно поставить из интерфейча luci. Далее перегрузить устройство.
Настройки awg появятся в разделе *Network/Interfaces/Add new interface*
