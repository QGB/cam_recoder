#!/bin/sh
#export TZ=Asia/Kolkata
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
echo $(date)
#NAME=$1
#DURATION=$2
#RTSP_URL=$3
#FORMAT=$4
#SEGMENT_FORMAT=$5
#TIMEOUT_BUFFER=$6
if [ ! -e /out/$NAME ]; then
  mkdir /out/$NAME
fi
chmod 775 /out/$NAME
TIMEOUT=$(( $DURATION + $TIMEOUT_BUFFER ))

while true
do
  echo "started at $(date)"
  echo "should timeout after $DURATION"

  # 获取当前日期和月份
  YEAR_MONTH=$(date +%Y-%m)
  DAY_TIME=$(date +%d_%H%M%S)

  # 创建月份文件夹
  MONTH_DIR="/out/${NAME}/${YEAR_MONTH}"
  if [ ! -e $MONTH_DIR ]; then
    mkdir -p $MONTH_DIR
  fi
  chmod 775 $MONTH_DIR

  timeout --kill-after $TIMEOUT_BUFFER -v $DURATION \
  ffmpeg -nostdin -loglevel $LOG_LEVEL \
  -y -i $RTSP_URL -timeout 60000000 \
  -vsync 1 -async -1 -an -vcodec copy \
  -t $DURATION \
  -f segment -strftime 1 -segment_time $DURATION \
  -segment_format $FORMAT "${MONTH_DIR}/${DAY_TIME}_${NAME}.$FORMAT" \
  -reset_timestamps 1 -segment_atclocktime 1 

  echo "stopped at $(date)"
  sleep 2;
done