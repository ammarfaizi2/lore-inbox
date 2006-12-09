Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1761343AbWLIBRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761343AbWLIBRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 20:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761346AbWLIBRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:17:52 -0500
Received: from mail.polish-dvd.com ([69.222.0.225]:59192 "HELO
	mail.webhostingstar.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761343AbWLIBRv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:17:51 -0500
Message-ID: <20061208190829.rvzeyaq4pxj40gko@69.222.0.225>
Date: Fri, 08 Dec 2006 19:08:29 -0600
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: 2.6.19-git libusual: modprobe for usb-storage succeeded, but
	module is not present
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org

2.6.19-git libusual: modprobe for usb-storage succeeded, but module is  
not present

Linux version 2.6.19-200612081830-g17097758  
(xxx@localhost.localdomain) (gcc version 4.1.1 20061011 ) #16 SMP  
PREEMPT Fri Dec 8 18:37:41 CST 2006
Command line: ro root=/dev/VolGroup00/LogVol00 rhgb mem=3583M
...
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
...
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
...
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
...
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 23 (level,  
low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0b.0: irq 23, io mem 0xfe02f000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 22 (level,  
low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: irq 22, io mem 0xfe02e000
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
SCSI subsystem initialized
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:03:09.0[A] -> Link [APC2] -> GSI 17 (level,  
low) -> IRQ 17
usb 2-1: new high speed USB device using ehci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
usb 2-2: new high speed USB device using ehci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
libusual: modprobe for usb-storage succeeded, but module is not present
usb 2-4: new high speed USB device using ehci_hcd and address 5
usb 2-4: configuration #1 chosen from 1 choice
libusual: modprobe for usb-storage succeeded, but module is not present
usb 2-5: new high speed USB device using ehci_hcd and address 6
usb 2-5: configuration #1 chosen from 1 choice
libusual: modprobe for usb-storage succeeded, but module is not present
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
xboom
