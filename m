Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278959AbRK1R6R>; Wed, 28 Nov 2001 12:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278879AbRK1R56>; Wed, 28 Nov 2001 12:57:58 -0500
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:48638 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S278701AbRK1R5m>; Wed, 28 Nov 2001 12:57:42 -0500
Message-ID: <3C052603.AF106014@ameritech.net>
Date: Wed, 28 Nov 2001 11:59:31 -0600
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: USB info for HP-318 Camera
Content-Type: multipart/mixed;
 boundary="------------E2AB27AF63BD46A9871D373D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E2AB27AF63BD46A9871D373D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

If anybody is interested this is a log
for plugging in an HP-318 digital camera.
{driver developers etc..}

It was running native mode and not a 
pc-disc mode.
--------------E2AB27AF63BD46A9871D373D
Content-Type: text/plain; charset=us-ascii;
 name="hp_318_camera"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hp_318_camera"

Nov 28 11:42:47 dali kernel: uhci.c: e400: wakeup_hc
Nov 28 11:42:47 dali kernel: uhci.c: root-hub INT complete: port1: 580 port2: 493 data: 4
Nov 28 11:42:47 dali kernel: hub.c: port 2 connection change
Nov 28 11:42:47 dali kernel: hub.c: port 2, portstatus 101, change 1, 12 Mb/s
Nov 28 11:42:48 dali kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Nov 28 11:42:48 dali kernel: hub.c: USB new device connect on bus1/2, assigned device number 2
Nov 28 11:42:48 dali kernel: uhci.c: uhci_result_control() failed with status 440000
Nov 28 11:42:48 dali kernel: [cff0d0c0] link (0ff0d062) element (0ff20210)
Nov 28 11:42:48 dali kernel:  Element != First TD
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e3 Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e0 Stalled CRC/Timeo Length=7ff MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:48 dali kernel: uhci.c: uhci_result_control() failed with status 440000
Nov 28 11:42:48 dali kernel: [cff0d0f0] link (0ff0d062) element (0ff201e0)
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:48 dali kernel: uhci.c: uhci_result_control() failed with status 440000
Nov 28 11:42:48 dali kernel: [cff0d0c0] link (0ff0d062) element (0ff201e0)
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:48 dali kernel: uhci.c: uhci_result_control() failed with status 440000
Nov 28 11:42:48 dali kernel: [cff0d0f0] link (0ff0d062) element (0ff201e0)
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:48 dali kernel: uhci.c: uhci_result_control() failed with status 440000
Nov 28 11:42:48 dali kernel: [cff0d0c0] link (0ff0d062) element (0ff201e0)
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:48 dali kernel: usb.c: USB device not responding, giving up (error=-110)
Nov 28 11:42:48 dali kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Nov 28 11:42:48 dali kernel: hub.c: USB new device connect on bus1/2, assigned device number 3
Nov 28 11:42:51 dali kernel: usb.c: kmalloc IF c6deaa40, numif 1
Nov 28 11:42:51 dali kernel: usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
Nov 28 11:42:51 dali kernel: usb.c: USB device number 3 default language ID 0x409
Nov 28 11:42:51 dali kernel: Manufacturer: Hewlett-Packard
Nov 28 11:42:51 dali kernel: Product: HP PhotoSmart 318 Camera
Nov 28 11:42:51 dali kernel: usb.c: unhandled interfaces on device
Nov 28 11:42:51 dali kernel: usb.c: USB device 3 (vend/prod 0x3f0/0x6302) is not claimed by any active driver.
Nov 28 11:42:51 dali kernel:   Length              = 18
Nov 28 11:42:51 dali kernel:   DescriptorType      = 01
Nov 28 11:42:51 dali kernel:   USB version         = 1.10
Nov 28 11:42:51 dali kernel:   Vendor:Product      = 03f0:6302
Nov 28 11:42:51 dali kernel:   MaxPacketSize0      = 8
Nov 28 11:42:51 dali kernel:   NumConfigurations   = 1
Nov 28 11:42:51 dali kernel:   Device version      = 1.00
Nov 28 11:42:51 dali kernel:   Device Class:SubClass:Protocol = 00:00:00
Nov 28 11:42:51 dali kernel:     Per-interface classes
Nov 28 11:42:51 dali kernel: Configuration:
Nov 28 11:42:51 dali kernel:   bLength             =    9
Nov 28 11:42:51 dali kernel:   bDescriptorType     =   02
Nov 28 11:42:51 dali kernel:   wTotalLength        = 0027
Nov 28 11:42:51 dali kernel:   bNumInterfaces      =   01
Nov 28 11:42:51 dali kernel:   bConfigurationValue =   01
Nov 28 11:42:51 dali kernel:   iConfiguration      =   00
Nov 28 11:42:51 dali kernel:   bmAttributes        =   c0
Nov 28 11:42:51 dali kernel:   MaxPower            =    0mA
Nov 28 11:42:51 dali kernel: 
Nov 28 11:42:51 dali kernel:   Interface: 0
Nov 28 11:42:51 dali kernel:   Alternate Setting:  0
Nov 28 11:42:51 dali kernel:     bLength             =    9
Nov 28 11:42:51 dali kernel:     bDescriptorType     =   04
Nov 28 11:42:51 dali kernel:     bInterfaceNumber    =   00
Nov 28 11:42:51 dali kernel:     bAlternateSetting   =   00
Nov 28 11:42:51 dali kernel:     bNumEndpoints       =   03
Nov 28 11:42:51 dali kernel:     bInterface Class:SubClass:Protocol =   06:01:01
Nov 28 11:42:51 dali kernel:     iInterface          =   00
Nov 28 11:42:51 dali kernel:     Endpoint:
Nov 28 11:42:51 dali kernel:       bLength             =    7
Nov 28 11:42:51 dali kernel:       bDescriptorType     =   05
Nov 28 11:42:51 dali kernel:       bEndpointAddress    =   81 (in)
Nov 28 11:42:51 dali kernel:       bmAttributes        =   02 (Bulk)
Nov 28 11:42:51 dali kernel:       wMaxPacketSize      = 0040
Nov 28 11:42:51 dali kernel:       bInterval           =   40
Nov 28 11:42:51 dali kernel:     Endpoint:
Nov 28 11:42:51 dali kernel:       bLength             =    7
Nov 28 11:42:51 dali kernel:       bDescriptorType     =   05
Nov 28 11:42:51 dali kernel:       bEndpointAddress    =   02 (out)
Nov 28 11:42:51 dali kernel:       bmAttributes        =   02 (Bulk)
Nov 28 11:42:51 dali kernel:       wMaxPacketSize      = 0040
Nov 28 11:42:51 dali kernel:       bInterval           =   00
Nov 28 11:42:51 dali kernel:     Endpoint:
Nov 28 11:42:51 dali kernel:       bLength             =    7
Nov 28 11:42:51 dali kernel:       bDescriptorType     =   05
Nov 28 11:42:51 dali kernel:       bEndpointAddress    =   85 (in)
Nov 28 11:42:51 dali kernel:       bmAttributes        =   03 (Interrupt)
Nov 28 11:42:51 dali kernel:       wMaxPacketSize      = 0008
Nov 28 11:42:51 dali kernel:       bInterval           =   10
Nov 28 11:42:51 dali kernel: usb.c: kusbd: /sbin/hotplug add 3
Nov 28 11:42:51 dali /sbin/hotplug: arguments (usb) env (PWD=/etc/hotplug HOSTNAME=dali.home_networks.com DEVICE=/proc/bus/usb/001/003 INTERFACE=6/1/1 ACTION=add DEBUG=kernel MACHTYPE=i586-mandrake-linux-gnu OLDPWD=/ DEVFS=/proc/bus/usb TYPE=0/0/0 SHLVL=1 SHELL=/bin/bash HOSTTYPE=i586 OSTYPE=linux-gnu HOME=/ TERM=dumb PATH=/bin:/sbin:/usr/sbin:/usr/bin PRODUCT=3f0/6302/100 _=/usr/bin/env)
Nov 28 11:42:51 dali /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Nov 28 11:42:51 dali /etc/hotplug/usb.agent: ... no drivers for USB product 3f0/6302/100
Nov 28 11:43:38 dali kernel: uhci.c: root-hub INT complete: port1: 580 port2: 48a data: 4
Nov 28 11:43:38 dali kernel: uhci.c: e400: suspend_hc
Nov 28 11:43:38 dali kernel: hub.c: port 2 connection change
Nov 28 11:43:38 dali kernel: hub.c: port 2, portstatus 100, change 3, 12 Mb/s
Nov 28 11:43:38 dali kernel: usb.c: USB disconnect on device 3
Nov 28 11:43:38 dali kernel: usb.c: kusbd: /sbin/hotplug remove 3
Nov 28 11:43:38 dali /sbin/hotplug: arguments (usb) env (PWD=/etc/hotplug HOSTNAME=dali.home_networks.com DEVICE=/proc/bus/usb/001/003 INTERFACE=6/1/1 ACTION=remove DEBUG=kernel MACHTYPE=i586-mandrake-linux-gnu OLDPWD=/ DEVFS=/proc/bus/usb TYPE=0/0/0 SHLVL=1 SHELL=/bin/bash HOSTTYPE=i586 OSTYPE=linux-gnu HOME=/ TERM=dumb PATH=/bin:/sbin:/usr/sbin:/usr/bin PRODUCT=3f0/6302/100 _=/usr/bin/env)
Nov 28 11:43:38 dali /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Nov 28 11:43:38 dali kernel: uhci.c: root-hub INT complete: port1: 580 port2: 488 data: 4
Nov 28 11:43:38 dali kernel: hub.c: port 2 enable change, status 100

--------------E2AB27AF63BD46A9871D373D
Content-Type: text/plain; charset=us-ascii;
 name="318_camera_kern_log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="318_camera_kern_log"

Nov 28 11:42:48 dali kernel: [cff0d0c0] link (0ff0d062) element (0ff20210)
Nov 28 11:42:48 dali kernel:  Element != First TD
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e3 Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e0 Stalled CRC/Timeo Length=7ff MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:48 dali kernel: [cff0d0f0] link (0ff0d062) element (0ff201e0)
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:48 dali kernel: [cff0d0c0] link (0ff0d062) element (0ff201e0)
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:48 dali kernel: [cff0d0f0] link (0ff0d062) element (0ff201e0)
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:48 dali kernel: [cff0d0c0] link (0ff0d062) element (0ff201e0)
Nov 28 11:42:48 dali kernel:   0: [cff201e0] link (0ff20210) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0707d600)
Nov 28 11:42:48 dali kernel:   1: [cff20210] link (0ff20240) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0eb8fec0)
Nov 28 11:42:48 dali kernel:   2: [cff20240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
Nov 28 11:42:48 dali kernel: 
Nov 28 11:42:51 dali kernel: usb.c: USB device 3 (vend/prod 0x3f0/0x6302) is not claimed by any active driver.
Nov 28 11:42:51 dali kernel:   Length              = 18
Nov 28 11:42:51 dali kernel:   DescriptorType      = 01
Nov 28 11:42:51 dali kernel:   USB version         = 1.10
Nov 28 11:42:51 dali kernel:   Vendor:Product      = 03f0:6302
Nov 28 11:42:51 dali kernel:   MaxPacketSize0      = 8
Nov 28 11:42:51 dali kernel:   NumConfigurations   = 1
Nov 28 11:42:51 dali kernel:   Device version      = 1.00
Nov 28 11:42:51 dali kernel:   Device Class:SubClass:Protocol = 00:00:00
Nov 28 11:42:51 dali kernel:     Per-interface classes
Nov 28 11:42:51 dali kernel: Configuration:
Nov 28 11:42:51 dali kernel:   bLength             =    9
Nov 28 11:42:51 dali kernel:   bDescriptorType     =   02
Nov 28 11:42:51 dali kernel:   wTotalLength        = 0027
Nov 28 11:42:51 dali kernel:   bNumInterfaces      =   01
Nov 28 11:42:51 dali kernel:   bConfigurationValue =   01
Nov 28 11:42:51 dali kernel:   iConfiguration      =   00
Nov 28 11:42:51 dali kernel:   bmAttributes        =   c0
Nov 28 11:42:51 dali kernel:   MaxPower            =    0mA
Nov 28 11:42:51 dali kernel: 
Nov 28 11:42:51 dali kernel:   Interface: 0
Nov 28 11:42:51 dali kernel:   Alternate Setting:  0
Nov 28 11:42:51 dali kernel:     bLength             =    9
Nov 28 11:42:51 dali kernel:     bDescriptorType     =   04
Nov 28 11:42:51 dali kernel:     bInterfaceNumber    =   00
Nov 28 11:42:51 dali kernel:     bAlternateSetting   =   00
Nov 28 11:42:51 dali kernel:     bNumEndpoints       =   03
Nov 28 11:42:51 dali kernel:     bInterface Class:SubClass:Protocol =   06:01:01
Nov 28 11:42:51 dali kernel:     iInterface          =   00
Nov 28 11:42:51 dali kernel:     Endpoint:
Nov 28 11:42:51 dali kernel:       bLength             =    7
Nov 28 11:42:51 dali kernel:       bDescriptorType     =   05
Nov 28 11:42:51 dali kernel:       bEndpointAddress    =   81 (in)
Nov 28 11:42:51 dali kernel:       bmAttributes        =   02 (Bulk)
Nov 28 11:42:51 dali kernel:       wMaxPacketSize      = 0040
Nov 28 11:42:51 dali kernel:       bInterval           =   40
Nov 28 11:42:51 dali kernel:     Endpoint:
Nov 28 11:42:51 dali kernel:       bLength             =    7
Nov 28 11:42:51 dali kernel:       bDescriptorType     =   05
Nov 28 11:42:51 dali kernel:       bEndpointAddress    =   02 (out)
Nov 28 11:42:51 dali kernel:       bmAttributes        =   02 (Bulk)
Nov 28 11:42:51 dali kernel:       wMaxPacketSize      = 0040
Nov 28 11:42:51 dali kernel:       bInterval           =   00
Nov 28 11:42:51 dali kernel:     Endpoint:
Nov 28 11:42:51 dali kernel:       bLength             =    7
Nov 28 11:42:51 dali kernel:       bDescriptorType     =   05
Nov 28 11:42:51 dali kernel:       bEndpointAddress    =   85 (in)
Nov 28 11:42:51 dali kernel:       bmAttributes        =   03 (Interrupt)
Nov 28 11:42:51 dali kernel:       wMaxPacketSize      = 0008
Nov 28 11:42:51 dali kernel:       bInterval           =   10

--------------E2AB27AF63BD46A9871D373D--

