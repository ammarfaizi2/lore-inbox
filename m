Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268453AbRHKQLR>; Sat, 11 Aug 2001 12:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268497AbRHKQLI>; Sat, 11 Aug 2001 12:11:08 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:60546 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S268453AbRHKQKx>;
	Sat, 11 Aug 2001 12:10:53 -0400
Date: Sat, 11 Aug 2001 20:13:49 +0400
From: s0mbre <johnpol@2ka.mipt.ru>
X-Mailer: The Bat! (v1.39) Educational
Reply-To: s0mbre <johnpol@2ka.mipt.ru>
X-Priority: 3 (Normal)
Message-ID: <19842.010811@2ka.mipt.ru>
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: [insmod don't work corrctly] /dev/hands damaged system
In-Reply-To: <2310.997545843@ocs3.ocs-net>
In-Reply-To: <2310.997545843@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, linux guru.

KO> On Sat, 11 Aug 2001 19:08:17 +0400, 
KO> s0mbre <johnpol@2ka.mipt.ru> wrote:
>>After recompiling -ac1( and -ac10, and -ac9, and -ac7) with
>>gcc-2.95.2( instead of 3.0 that doesn't work in principle), i collide
>>with strange behavior of lsmod:
>>
>>[root@Sombre s0mbre]# insmod /lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o
>>/lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o: unresolved symbol __kfree_skb

KO> http://www.tux.org/lkml/#s8-8

Before all recompilings i deleted whole dir with kernel source becouse
of order to applying patches.
And every time i run make menuconfig anew.
That is new code, new config, new Makefile.

Or am I missing a think once more?


---
WBR. //s0mbre


