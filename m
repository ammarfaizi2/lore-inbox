Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVLZFXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVLZFXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 00:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVLZFXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 00:23:52 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:8102 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751018AbVLZFXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 00:23:51 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
Date: Mon, 26 Dec 2005 16:23:43 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <fkouq1tvbh046b2pfn24maarj4ne8g3bcb@4ax.com>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Dec 2005 19:39:23 -0800 (PST), Linus Torvalds <torvalds@osdl.org> wrote:

>
>Please do give it a try, and if you have any issues/regressions, send out 
>a note (even if you sent one earlier) so that we don't forget about it.

For first time I tried running firewall box on 2.6 series with 15-rc7, 
worked first time: http://bugsplatter.mine.nu/test/boxen/deltree/, an 
old pentium/mmx with f00f bug.

Only copied /etc/modules.conf to /etc/modprobe.conf, iptables and 
all else (NFS, ADSL, Samba) working without change to .conf files.

Thanks,
Grant.
