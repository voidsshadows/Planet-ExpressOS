### Connectivity check block binary patch

Jumps past these 4 lines ([source referece](https://github.com/elegooofficial/CentauriCarbon/blob/20a2d9b40e0005746c300766e0b526934997805e/firmware/hl/devices/hl_net.c#L218)) using a simple `b 0x294310` statement.

```c
    HL_ASSERT(hl_tpool_create_thread(&net_lan_connect_detction_thread, net_lan_connect_detection_routine, NULL, 0, 0, 0, 0) == 0);
    HL_ASSERT(hl_tpool_create_thread(&net_wan_connect_detction_thread, net_wan_connect_detection_routine, NULL, 0, 0, 0, 0) == 0);
    HL_ASSERT(hl_tpool_wait_started(net_lan_connect_detction_thread, 0) == 1);
    HL_ASSERT(hl_tpool_wait_started(net_wan_connect_detction_thread, 0) == 1);
```