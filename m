Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288662AbSBDH35>; Mon, 4 Feb 2002 02:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSBDH3s>; Mon, 4 Feb 2002 02:29:48 -0500
Received: from deepthought.blinkenlights.nl ([62.58.162.228]:8196 "EHLO
	deepthought.blinkenlights.nl") by vger.kernel.org with ESMTP
	id <S288662AbSBDH3m>; Mon, 4 Feb 2002 02:29:42 -0500
Date: Mon, 4 Feb 2002 08:36:40 +0100 (CET)
From: Sten <sten@blinkenlights.nl>
To: linux-kernel@vger.kernel.org
Subject: IPv6 Sparc64
Message-ID: <Pine.LNX.4.44-Blink.0202040829140.19625-100000@deepthought.blinkenlights.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been trying to get ipv6 to work
on sparc64/kernel 2.4 but it looks like it
is broken somewhere in the kernel.
I was wondering if this was a known problem.


lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:84 errors:0 dropped:0 overruns:0 frame:0
          TX packets:84 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:8736 (8.5 Kb)  TX bytes:8736 (8.5 Kb)

[root@towel ip]# ping6 ::1
PING ::1(::1) from ::1 : 56 data bytes


-- 
Sten Spans

  "What does one do with ones money,
   when there is no more empty rackspace ?"

