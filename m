Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbUJ0EdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUJ0EdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUJ0EdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:33:21 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:57947 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261622AbUJ0EdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:33:17 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [2.6.10-rc1-bk5] e1000 broken badly on IBM T42
Date: Wed, 27 Oct 2004 00:33:22 -0400
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410270033.22804.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
NETDEV WATCHDOG: eth0: transmit timed out

eth0      Link encap:Ethernet  HWaddr 00:0D:60:CA:C1:97
          inet addr:192.168.10.5  Bcast:192.168.10.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4294883167 errors:4294370903 dropped:4294796898 overruns:4294882097 frame:4294711699
          TX packets:4294883949 errors:4294796898 dropped:0 overruns:0 carrier:4294711699
          collisions:4294882097 txqueuelen:1000
          RX bytes:470309 (459.2 KiB)  TX bytes:108971 (106.4 KiB)
          Base address:0x8000 Memory:c0220000-c0240000


I can't even use the interface, some counters are going up others going backwards? ;-)

Anyone notice this?

Shawn.
