Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUBKTbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUBKTbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:31:02 -0500
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:34043 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265693AbUBKTay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:30:54 -0500
Message-ID: <402A82EB.6010405@earthlink.net>
Date: Wed, 11 Feb 2004 14:30:51 -0500
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: spontaneous reboots 2.6
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle people,

Since 2.6.2-rc1 on Jan 26 thru 2.6.2-mm1 I have had 5 occasions where my 
system rebooted, nothing shows up in the system log. I had been using 
2.4.20 without ever having had this happen.

Anybody have any ideas or additional information I can provide?

Hardware:
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP]
00:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 02)
00:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 02)
00:09.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 
10/100 model NC100 (rev 11)
00:0a.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 
10/100 model NC100 (rev 11)
00:0b.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 
10] (rev 08)
00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20265 
(rev 02)
00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 70)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP

