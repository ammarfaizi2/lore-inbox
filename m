Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWATQml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWATQml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWATQmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:42:40 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:60041 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751078AbWATQmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:42:40 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Fri, 20 Jan 2006 17:41:52 +0100
To: Harald Welte <laforge@netfilter.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S.Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2]
In-reply-to: <20060120163619.GK4603@sunbeam.de.gnumonks.org>
References: <20060120031555.7b6d65b7.akpm@osdl.org> <20060120162317.5F70722B383@anxur.fi.muni.cz>
Message-Id: <20060120164150.B765622AEAC@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
>On Fri, Jan 20, 2006 at 05:23:18PM +0100, Jiri Slaby wrote:
>> Commit 4f2d7680cb1ac5c5a70f3ba2447d5aa5c0a1643a (Linus' 2.6 git tree) bre=
>aks my
>> iptables (1.3.4):
>
>You missed to indicate on which architecture?
Of course I did, sorry:
Linux bellona 2.6.16-rc1-mm2good #89 SMP PREEMPT Fri Jan 20 17:05:23 CET 2006 i686 i686 i386 GNU/Linux
not ppc, not 64 bit...

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
