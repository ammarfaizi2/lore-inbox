Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbTCTFxG>; Thu, 20 Mar 2003 00:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbTCTFxG>; Thu, 20 Mar 2003 00:53:06 -0500
Received: from w1312.hostcentric.net ([66.40.206.254]:33293 "HELO
	w1312.hostcentric.net") by vger.kernel.org with SMTP
	id <S261391AbTCTFxF>; Thu, 20 Mar 2003 00:53:05 -0500
Date: Thu, 20 Mar 2003 06:04:02 -0000
To: <linux-kernel@vger.kernel.org>
Subject: Do and Don'ts for socket programming from kernel module/kernel-thread
From: <nalin@impulsesoft.com>
X-Mailer: TWIG 2.7.4
X-Client-IP: 202.9.179.70
Message-Id: <20030320055305Z261391-25575+33069@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friends,

Where could I find some tips and tricks for correctly doing socket programming
from a kernel module and a kernel thread.

I am totally stuck and not able to proceed.

I am invariably getting kernel panic from __skb_dequeue inline function called
from alloc_skb.

In detail I posted following mail, but unfortunately it could not attract
anyones attention.

Sub : alloc_skb panic oops / virtual network interface
URL:  http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.2/0437.html


Hope to get some response and much need guidance from linux gurus.

thanks in advance,

regards
- nalin
