#!/system/bin/sh

#Script by rodries @xda, oipr @xda and milouk @xda

setSphinxConfig() {

chmod 664 scaling_min_freq
echo 10 > /sys/class/thermal/thermal_message/sconfig

sleep 15

# configure boosts
echo 15 > /sys/module/cpu_boost/parameters/dynamic_stune_boost;
echo 350 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 500 > /sys/module/cpu_boost/parameters/powerkey_input_boost_ms
echo "0:0" > /sys/module/cpu_boost/parameters/input_boost_freq

# Disable touchboost
echo 0 > /sys/module/msm_performance/parameters/touchboost

#echo 0 /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
#echo 0 /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
# Enable iowait boost to ramp up the CPU on repeated iowait wakeups
#echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/iowait_boost_enable
#echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/iowait_boost_enable

# Tweak IO performance after boot complete
echo "zen" > /sys/block/sda/queue/scheduler
echo 128 > /sys/block/sda/queue/read_ahead_kb
echo 128 > /sys/block/sda/queue/nr_requests
echo 1 > /sys/block/sda/queue/iostats
echo 128 > /sys/block/sdf/queue/read_ahead_kb
echo 128 > /sys/block/sdf/queue/nr_requests
echo 1 > /sys/block/sdf/queue/iostats

# Enable scheduler core_ctl
echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/enable
echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/enable

# Enable Power Efficient Workqueques
echo 1 > /sys/module/workqueue/parameters/power_efficient

#Diaable Fsync
echo Y > /sys/module/sync/parameters/fsync_enabled

# set default schedTune value for foreground/top-app (only affects EAS)
echo 1 > /dev/stune/foreground/schedtune.prefer_idle
echo 1 > /dev/stune/top-app/schedtune.prefer_idle
echo 5 > /dev/stune/foreground/schedtune.sched_boost
echo 0 > /dev/stune/background/schedtune.sched_boost
echo 20 > /dev/stune/top-app/schedtune.sched_boost

# Increase how much CPU bandwidth (CPU time) realtime scheduling processes are given
echo "980000" > /proc/sys/kernel/sched_rt_runtime_us #minor increase stock is 9500000

# Network tweaks for slightly reduced battery consumption when being "actively" connected to a network connection;
echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control

#set defult governor
echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor

echo 1 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
echo 1 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pl

#force min_freq
echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

# Change l3-cdsp to userspace governor
echo userspace > /sys/class/devfreq/soc:qcom,l3-cdsp/governor

# Enable bus-dcvs
echo "bw_hwmon" > /sys/class/devfreq/soc:qcom,cpubw/governor
echo 50 > /sys/class/devfreq/soc:qcom,cpubw/polling_interval
echo "2288 4577 6500 8132 9155 10681" > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/mbps_zones
echo 4 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/sample_ms
echo 40 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent
echo 20 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hist_memory
echo 10 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hyst_length
echo 0 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps
echo 250 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/up_scale
echo 1600 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/idle_mbps


# Toggle Sched Features
echo "NO_FBT_STRICT_ORDER" > /sys/kernel/debug/sched_features

sleep 25
#force min_freq again  
echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

}

setSphinxConfig &
