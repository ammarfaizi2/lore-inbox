Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131115AbRCJSvf>; Sat, 10 Mar 2001 13:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbRCJSvP>; Sat, 10 Mar 2001 13:51:15 -0500
Received: from albireo.ucw.cz ([62.168.0.14]:57605 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S131115AbRCJSvF>;
	Sat, 10 Mar 2001 13:51:05 -0500
Date: Sat, 10 Mar 2001 19:50:06 +0100
From: Martin Mares <mj@suse.cz>
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
Message-ID: <20010310195006.A2670@albireo.ucw.cz>
In-Reply-To: <3AA89624.46DBADD7@idb.hist.no> <200103091152.MAA31645@cave.bitwizard.nl> <20010309152902.A1219@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010309152902.A1219@mail.harddata.com>; from michal@harddata.com on Fri, Mar 09, 2001 at 03:29:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Well, not really in this situation, after a simple modification.  It is
> trivial to show that using "shorter interval sorted first" approach one
> can bound an amount of an extra memory, on stack or otherwise, and by a
> rather small number.

By O(log N) which is in reality a small number :)

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"Dijkstra probably hates me." -- /usr/src/linux/kernel/sched.c
