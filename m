Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbUL3UP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbUL3UP0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 15:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUL3UP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 15:15:26 -0500
Received: from black.click.cz ([62.141.0.10]:57741 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S261709AbUL3UPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 15:15:08 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: for USB guys - strange things in dmesg
Date: Thu, 30 Dec 2004 21:13:00 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412302113.00357.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

when inserting my Bluetooth dongle into USB port, I get into dmesg this:
Bluetooth: RFCOMM ver 1.4
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
usb 3-1: USB disconnect, address 3
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: can't resubmit intr, 0000:00:1d.2-1/input1, 
status -19
usb 3-1: new full speed USB device using uhci_hcd and address 4
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
------
Dongle boots in HID proxy mode, then is switched - list is the same after 
switching.
But USB dongle normally works.

Thanks for fixing

Michal 
