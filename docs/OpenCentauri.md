# OpenCentauri Firmware Notes

A collection of PD's notes on the current status of low-level OpenCentauri firmware development.

---

## 2025-08-29 Update

### Recent Progress

Release **v0.0.4** introduced Serial UART console and uBoot access on power-up.

#### Recommended Setup

- **Set uBoot boot delay:**
  ```bash
  fw_setenv bootdelay 5
  ```
  This sets a 5-second delay before uBoot continues the start-up sequence, allowing you to interrupt via the Serial console.

- **List all parameters:**
  ```bash
  fw_printenv
  ```
  *Tip: Save a copy of the stock settings before making changes.*

#### Serial Console Access

- Connect a USB serial adapter (or other serial interface) to the **Tx, Rx, and Ground** pins on the Centauri mainboard.
- Baud rate: **115200**
- Reboot the Carbon and observe the boot-up process.  
  *Press any key to interrupt boot!*

---

## Booting Without DSP

To boot from uBoot without loading DSP firmware:

```bash
run setargs_mmc
run boot_normal
```

This skips the `boot_dsp0` argument, preventing DSP firmware from loading.

---

## Removing DSP from Linux Device Tree (Temporary)

To remove the DSP from the Linux device tree for a single boot (changes revert on reboot):

```bash
fdt addr ${fdt_addr}
fdt print /
fdt rm dsp0
fdt rm dsp0_gpio_int
run setargs_mmc
run boot_normal
```

---

## Modifying Pin Control for PE9 and PE6

To force a pull-up resistor on PE9 and PE6, use the following device tree overlay:

```dts
target-path = "/pinctrl@2000000";
__overlay__ {
    pe9_gpio: pe9-gpio {
        pins = "PE9";
        function = "gpio_in";
        bias-pull-up;
    };
    pe6_gpio: pe6-gpio {
        pins = "PE6";
        function = "gpio_in";
        bias-pull-up;
    };
};
```

### Equivalent uBoot `fdt` Commands

1. **Disable DSP blocks:**
    ```bash
    fdt set /dsp0 status disabled
    fdt set /dsp0_gpio_int status disabled
    ```

2. **Configure PE9 and PE6 as GPIOs with pull-ups:**
    ```bash
    fdt mknode /pinctrl@2000000 pe9-gpio
    fdt mknode /pinctrl@2000000 pe6-gpio

    # For PE9 (gpio137)
    fdt set /pinctrl@2000000/pe9-gpio pins "PE9"
    fdt set /pinctrl@2000000/pe9-gpio function "gpio_in"
    fdt set /pinctrl@2000000/pe9-gpio bias-pull-up

    # For PE6 (gpio134)
    fdt set /pinctrl@2000000/pe6-gpio pins "PE6"
    fdt set /pinctrl@2000000/pe6-gpio function "gpio_in"
    fdt set /pinctrl@2000000/pe6-gpio bias-pull-up
    ```

**Note:** Configuring pinctrl for these GPIOs in the device tree may make them unavailable for general-purpose GPIO use in Linux.

---

## Register Interface for GPIO Configuration

If device tree changes are insufficient, you can use the `/sys/class/sunxi_dump/*` interface to modify GPIO registers directly.

### Reference: [R528 User Manual](https://bbs.aw-ol.com/assets/uploads/files/1645007527374-r528_user_manual_v1.3.pdf)

#### Relevant Registers

- **GPIO Base:** `0x02000000`
- **PE Configure Register 0:** `0x00C0`
- **PE Configure Register 1:** `0x00C4`
- **PE Data Register:** `0x00D0`
- **PE Multi_Driving Register 0:** `0x00D4`
- **PE Multi_Driving Register 1:** `0x00D8`
- **PE Pull Register 0:** `0x00E4`

##### Pull Register Bits

- **PE9_PULL (bits 19:18):**
  - `00`: Pull-up/down disable
  - `01`: Pull-up
  - `10`: Pull-down
  - `11`: Reserved
- **PE6_PULL (bits 13:12):**
  - Same as above

#### Example Commands

```bash
# Set PE9 and PE6 pull-up
echo "0x020000E4 0x50041050" > /sys/class/sunxi_dump/write
cat /sys/class/sunxi_dump/read

# Configure PE6 IN, PE9 OUT
echo "0x020000C0 0xF0FFFFFF" > /sys/class/sunxi_dump/write
echo "0x020000C4 0xFFFFFF1F" > /sys/class/sunxi_dump/write
```

---

## Additional Resources

- **Rust register interface for R528:**  
  [r528-pac crate documentation](https://docs.rs/r528-pac/latest/r528_pac/)

---

## Next Steps

- Continue experimenting with `/sys` interface to configure PE6/PE9 UARTs for Klipper MCU.
- Investigate missing GPIOs accessible by DSP and remap via uBoot device tree hacks.
- Consider building a replacement kernel for easier device tree control.
- Explore device tree overlays or sideloading replacement DTs.
- Evaluate if uBoot commands alone provide sufficient control for current needs.