Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVDDQ1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVDDQ1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 12:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVDDQ1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 12:27:37 -0400
Received: from relay03.roc.ny.frontiernet.net ([66.133.182.166]:57241 "EHLO
	relay03.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261269AbVDDQ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 12:27:33 -0400
Subject: Re: Software Suspend on Sony Vaio R505E
From: Aaron Gaudio <prothonotar@tarnation.dyndns.org>
Reply-To: prothonotar@tarnation.dyndns.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <1112580660.5797.23.camel@localhost.localdomain>
References: <1112580660.5797.23.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-/WQD3xlFeoeLlsxd9nbv"
Date: Mon, 04 Apr 2005 12:27:27 -0400
Message-Id: <1112632048.5797.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/WQD3xlFeoeLlsxd9nbv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ooops! I selected the wrong file to attach. Here is the proper syslog
attachment...

--=-/WQD3xlFeoeLlsxd9nbv
Content-Disposition: attachment; filename=suspend_log.txt
Content-Type: text/plain; name=suspend_log.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

/var/log/messages:
Apr  3 13:07:04 localhost kernel: .swsusp: Restoring Highmem
Apr  3 13:07:04 localhost kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
Apr  3 13:07:06 localhost kernel: ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
Apr  3 13:07:07 localhost kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
Apr  3 13:07:09 localhost kernel: ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 9 (level, low) -> IRQ 9
Apr  3 13:07:09 localhost kernel: Restarting tasks... done
Apr  3 13:07:09 localhost kernel: eth1: New link status: Connected (0001)
Apr  3 13:07:10 localhost kernel: usb 3-1: USB disconnect, address 2
Apr  3 13:07:10 localhost kernel: sda : READ CAPACITY failed.
Apr  3 13:07:10 localhost kernel: sda : status=0, message=00, host=1, driver=00
Apr  3 13:07:10 localhost kernel: sda : sense not available.
Apr  3 13:07:10 localhost kernel: sda: Write Protect is off
Apr  3 13:07:10 localhost kernel: sda: assuming drive cache: write through
Apr  3 13:07:10 localhost kernel: sda : READ CAPACITY failed.
Apr  3 13:07:10 localhost kernel: sda : status=0, message=00, host=1, driver=00
Apr  3 13:07:10 localhost kernel: sda : sense not available.
Apr  3 13:07:10 localhost kernel: sda: Write Protect is off
Apr  3 13:07:10 localhost kernel: sda: assuming drive cache: write through
Apr  3 13:07:10 localhost kernel:  sda:<3>scsi0 (0:0): rejecting I/O to device being removed
Apr  3 13:07:10 localhost kernel: Buffer I/O error on device sda, logical block 0
Apr  3 13:07:10 localhost kernel: scsi0 (0:0): rejecting I/O to device being removed
Apr  3 13:07:10 localhost kernel: Buffer I/O error on device sda, logical block 0
Apr  3 13:07:10 localhost kernel: scsi0 (0:0): rejecting I/O to device being removed
Apr  3 13:07:10 localhost kernel: Buffer I/O error on device sda, logical block 0
Apr  3 13:07:10 localhost kernel:  unable to read partition table
Apr  3 13:07:10 localhost kernel: usb 3-1: new full speed USB device using uhci_hcd and address 3
Apr  3 13:07:12 localhost kernel: NETDEV WATCHDOG: eth1: transmit timed out
Apr  3 13:07:12 localhost kernel: eth1: Tx timeout! ALLOCFID=00c0, TXCOMPLFID=00bf, EVSTAT=808b
Apr  3 13:07:15 localhost kernel: eth1: New link status: Connected (0001)
Apr  3 13:07:18 localhost kernel: NETDEV WATCHDOG: eth1: transmit timed out
Apr  3 13:07:18 localhost kernel: eth1: Tx timeout! ALLOCFID=00c0, TXCOMPLFID=00bf, EVSTAT=808b
Apr  3 13:07:25 localhost kernel: eth1: New link status: Connected (0001)
Apr  3 13:07:25 localhost kernel: usb 3-1: 05-wait_for_sys timed out on ep0in
Apr  3 13:07:25 localhost kernel: usb 3-1: khubd timed out on ep0in
Apr  3 13:07:26 localhost kernel: NETDEV WATCHDOG: eth1: transmit timed out
Apr  3 13:07:26 localhost kernel: eth1: Tx timeout! ALLOCFID=00c0, TXCOMPLFID=00bf, EVSTAT=808b
Apr  3 13:07:30 localhost kernel: usb 3-1: khubd timed out on ep0in
Apr  3 13:07:30 localhost kernel: usb 3-1: string descriptor 0 read error: -110
Apr  3 13:07:33 localhost NET: /sbin/dhclient-script : updated /etc/resolv.conf
Apr  3 13:07:35 localhost kernel: usb 3-1: 05-wait_for_sys timed out on ep0in
Apr  3 13:07:35 localhost hal.hotplug[8361]: timout(10000 ms) waiting for /devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.0
Apr  3 13:07:36 localhost hald[4527]: Timed out waiting for hotplug event 785. Rebasing to 786
Apr  3 13:07:40 localhost kernel: usb 3-1: khubd timed out on ep0in
Apr  3 13:07:45 localhost kernel: usb 3-1: khubd timed out on ep0in
Apr  3 13:07:45 localhost kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Apr  3 13:07:45 localhost kernel: usb 3-1: 05-wait_for_sys timed out on ep0in
Apr  3 13:07:55 localhost kernel: usb 3-1: hald timed out on ep0in
Apr  3 13:08:10 localhost kernel: usb 3-1: hald timed out on ep0in
Apr  3 13:08:10 localhost kernel: usb 3-1: reset full speed USB device using uhci_hcd and address 3
Apr  3 13:08:30 localhost kernel: usb 3-1: hald timed out on ep0in
Apr  3 13:08:35 localhost kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
Apr  3 13:08:40 localhost kernel: usb 3-1: hald timed out on ep0in


--=-/WQD3xlFeoeLlsxd9nbv--

