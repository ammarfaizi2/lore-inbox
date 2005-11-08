Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbVKHWIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVKHWIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVKHWIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:08:11 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:47274
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1030320AbVKHWIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:08:10 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: linux-kernel@vger.kernel.org
Subject: USB Key Kingston DataTraveler
Date: Tue, 8 Nov 2005 17:08:12 -0500
Message-Id: <20051108220525.M81553@linuxwireless.org>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an IBM T42 with 2.6.14-git and this specific USB Key has never worked
for me. Any idea?

USB Key Kingston DataTraveler


hub 4-0:1.0: state 5 ports 6 chg 0000 evt 0010
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 001803 POWER sig=j CSC CONNECT
hub 4-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
hub 4-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:1d.7: port 4 high speed
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 001005 POWER sig=se0 PE CONNECT
usb 4-4: new high speed USB device using ehci_hcd and address 5
ehci_hcd 0000:00:1d.7: port 4 high speed
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 001005 POWER sig=se0 PE CONNECT
usb 4-4: default language 0x0409
usb 4-4: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-4: Product: DataTraveler 2.0
usb 4-4: Manufacturer: Kingston
usb 4-4: SerialNumber: 2840E64152121B80
usb 4-4: hotplug
usb 4-4: adding 4-4:1.0 (config #1, interface 0)
usb 4-4:1.0: hotplug
usb-storage 4-4:1.0: usb_probe_interface
usb-storage 4-4:1.0: usb_probe_interface - got id
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
  Vendor: Kingston  Model: DataTraveler 2.0  Rev: 4.10
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdb: 251904 512-byte hdwr sectors (129 MB)
sdb: Write Protect is off
sdb: Mode Sense: 0b 00 00 08
sdb: assuming drive cache: write through
SCSI device sdb: 251904 512-byte hdwr sectors (129 MB)
sdb: Write Protect is off
sdb: Mode Sense: 0b 00 00 08
sdb: assuming drive cache: write through
 sdb: [CUMANA/ADFS] sdb1<5>sd 2:0:0:0: Attached scsi removable disk sdb
sd 2:0:0:0: Attached scsi generic sg1 type 0
usb-storage: device scan complete
printk: 4 messages suppressed.
Buffer I/O error on device sdb1, logical block 508378384
Buffer I/O error on device sdb1, logical block 508378384
Buffer I/O error on device sdb1, logical block 508378412
Buffer I/O error on device sdb1, logical block 508378412
Buffer I/O error on device sdb1, logical block 508378412
Buffer I/O error on device sdb1, logical block 508378412
Buffer I/O error on device sdb1, logical block 508378412

--
Open WebMail Project (http://openwebmail.org)

