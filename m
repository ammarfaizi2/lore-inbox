Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281285AbRKETWZ>; Mon, 5 Nov 2001 14:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281286AbRKETWN>; Mon, 5 Nov 2001 14:22:13 -0500
Received: from [195.66.192.167] ([195.66.192.167]:26634 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281285AbRKETWF>; Mon, 5 Nov 2001 14:22:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: task `ifconfig' exit_signal 17 in reparent_to_init
Date: Mon, 5 Nov 2001 21:21:58 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01110521215800.00884@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.13. In my bootscript messages I see

* Configuring loopback: 127.0.0.1
* Attempting to configure eth0 by contacting a DHCP server...
dhcpcd: your IP address = 172.16.42.84
* Configuring eth1: 172.16.241.2
- ifconfig eth1
task `ifconfig' exit_signal 17 in reparent_to_init   <-----

Dunno is it normal or what, thought somebody will find this info useful...
eth1 is configured and working fine (I'm connecting to NFS server over it).
--
vda
