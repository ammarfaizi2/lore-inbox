Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbVISVJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbVISVJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVISVJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:09:41 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:52883 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S932694AbVISVJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:09:40 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: progress report ons doomes-day machine (usenet gateway): 2.6.14-rc1-git1 over 3 days!
Date: Mon, 19 Sep 2005 21:09:39 +0000 (UTC)
Organization: Cistron
Message-ID: <dgn9ej$n9j$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1127164179 23859 62.216.30.70 (19 Sep 2005 21:09:39 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6.14-rc1-git1 (root@newsgate) (gcc [can't parse]) #???  1CPU
[newsgate.(none)]

Memory:      Total        Used        Free      Shared     Buffers
Mem:       4062048     4038020       24028           0        3016
Swap:            0           0           0

Bootup: Fri Sep 16 09:04:23 2005    Load average: 7.09 5.18 4.46 10/80
29403

user  :      10:06:40.29  11.8%  page in :        0
nice  :       1:23:05.12   1.6%  page out:        0
system:   1d  4:57:29.89  33.7%  swap in :        0
idle  :       0:10:47.82   0.2%  swap out:        0
uptime:   3d 13:56:05.26         context :1007169643

irq  0:  77327243 timer                 irq 12:         3
irq  1:         8 i8042                 irq 16:  82013319 aic79xx
irq  4:       337 serial                irq 17: 858271905 aic79xx, eth3
irq  9:         0 acpi                  irq 18:1672823586 acenic

It's doing fine so far (none of the 2.6.13-xx kernels made it this
far)


Only thing not working so far is the SMP setup although i some progress
mentioned in git4. Will try soon!

Danny

