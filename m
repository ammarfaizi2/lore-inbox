Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSKOFmM>; Fri, 15 Nov 2002 00:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSKOFmM>; Fri, 15 Nov 2002 00:42:12 -0500
Received: from web41005.mail.yahoo.com ([66.218.93.4]:52579 "HELO
	web41005.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265806AbSKOFmL>; Fri, 15 Nov 2002 00:42:11 -0500
Message-ID: <20021115054901.2435.qmail@web41005.mail.yahoo.com>
Date: Thu, 14 Nov 2002 21:49:01 -0800 (PST)
From: Joyce Tan <blutot@yahoo.com>
Subject: bug in hci_usb (bluetooth usb driver) in linux-2.5.47?
To: kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried testing linux-2.5.47 with builtin bluetooth
support with ohci.
I get this error when I do "hciconfig".


root@Javelina kernel]$hciconfig hci0 up
hci_usb_send_ctrl: hci0 ctrl tx submit failed urb
c6bd76e0 err -90
Can't init device hci0. Connection timed out(110)
[root@Javelina kernel]$

joyce
~


__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - Let the expert host your site
http://webhosting.yahoo.com
