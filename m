Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVI3QWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVI3QWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVI3QWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:22:31 -0400
Received: from news.cistron.nl ([62.216.30.38]:3977 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1030322AbVI3QWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:22:31 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: 2.6.14-rc2-git7 crashed on amd64 (usenet gateway) after 18 hours
Date: Fri, 30 Sep 2005 16:22:30 +0000 (UTC)
Organization: Cistron
Message-ID: <dhjoo5$86q$1@news.cistron.nl>
References: <dhinf5$skf$1@news.cistron.nl> <20050930001301.08eeab9d.akpm@osdl.org> <20050930073958.GA24985@dth.net> <20050930124448.GA12779@favonius>
X-Trace: ncc1701.cistron.net 1128097350 8410 62.216.30.70 (30 Sep 2005 16:22:30 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander  <sander@humilis.net> wrote:
>This might help?
>From 'man screen':
>       C-a H       (log)         Begins/ends logging of the current window  to
>                                 the file "screenlog.n".

*thanks*

done so.

If it crashes i know now at leas i will have _all_ output!

git8 stil running:
-------------
newsgate:~# procinfo
Linux 2.6.14-rc2-git8 (root@newsgate) (gcc 4.0.2 ) #1 1CPU [newsgate.(none)]

Memory:      Total        Used        Free      Shared     Buffers
Mem:       4062040     4041212       20828           0         568
Swap:            0           0           0

Bootup: Fri Sep 30 10:21:34 2005    Load average: 4.73 4.60 4.47 5/74 23214

user  :       0:57:57.56  12.1%  page in :        0
nice  :       0:08:26.32   1.8%  page out:        0
system:       2:23:25.64  29.9%  swap in :        0
idle  :       0:01:16.27   0.3%  swap out:        0
uptime:       7:59:59.89         context : 77591356

irq  0:   7195064 timer                 irq 12:         3
irq  1:         8 i8042                 irq 16:   7430483 aic79xx
irq  4:       400 serial                irq 17:  73394066 aic79xx, eth3
irq  9:         0 acpi                  irq 18: 138587870 acenic

--------------

Danny

