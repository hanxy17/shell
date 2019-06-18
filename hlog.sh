#!/usr/bin/env bash
# 根据日志级别分别着色，并限制低级别日志的输出
#设置日志级别
logLevel=${LOG_LEVEL:-0} #debug:0; info:1; warn:2; error:3
function privateLog() {
# 需要两个入参，$1 是打印级别 ,$2 是打印内容,只有一个参数的，默认是打印内容并且是最低级别打印
    local logType
    local msg
    logType=$1
    shift
    msg=$@
    dateTime=`date +'%F %H:%M:%S'`
    # 这里需要很巧妙的计算tab的数量来控制对齐
    logFormat="[${logType}]\t${dateTime}\tfuncname:${FUNCNAME[@]/privateLog/}\t[line:`caller 0 | awk '{print $1}'`]\t${msg}"
    case $logType in
        debug)
            [[ ${logLevel} -le 0 ]] && echo -e "\033[30m${logFormat}\033[0m" ;;
        info)
            [[ ${logLevel} -le 1 ]] && echo -e "\033[32m${logFormat}\033[0m" ;;
        warn)
            [[ ${logLevel} -le 2 ]] && echo -e "\033[33m${logFormat}\033[0m" ;;
        error)
            [[ ${logLevel} -le 3 ]] && echo -e "\033[31m${logFormat}\033[0m" ;;
    esac
}
function logDebug() {
    privateLog debug $@
}
function logInfo() {
    privateLog info $@
}
function logWarn() {
    privateLog warn $@
}
function logError() {
    privateLog error $@
}
logDebug "debug?" 2 3 4 5 6 7 8 9
logInfo "info?" 2 3 4 5 6 7 8 9
logWarn "warn?" 2 3 4 5 6 7 8 9
logError "error?" 2 3 4 5 6 7 8 9 '$PATH'
