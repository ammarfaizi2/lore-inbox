Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279783AbRKFQGe>; Tue, 6 Nov 2001 11:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279768AbRKFQGY>; Tue, 6 Nov 2001 11:06:24 -0500
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:30217 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S279739AbRKFQGI>; Tue, 6 Nov 2001 11:06:08 -0500
Message-ID: <3BE80A55.95F73193@cis.nctu.edu.tw>
Date: Wed, 07 Nov 2001 00:05:41 +0800
From: Chun-Ying Huang <huangant@cis.nctu.edu.tw>
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with gigabit NIC acenic: 3c985b-sx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Dear all:

	I've install a 3c985b-sx NIC on my linux 2.4.13 box.
	But when loading the 'acenic' module, it shows the message:

eth1: 3Com 3C985 Gigabit Ethernet at 0xdf020000, irq 10
  Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:60:08:f7:04:1e
  PCI bus width: 32 bits, speed: 33MHz, latency: 64 clks
eth1: Firmware NOT running!

	(PS. My eth0 is an intel eepro100)

	It seems the driver detect the card but can't work.
	Is this a bug of my NIC firmware or a problem of
	the driver? Or what necessary steps I've missed?

	Thanks in advance.

	PS. Please CC your replis to me, thank you in advance.:)

--
Regards,
huangant <Chun-Ying Huang>
