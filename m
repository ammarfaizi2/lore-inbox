Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbTCGHhH>; Fri, 7 Mar 2003 02:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261423AbTCGHhG>; Fri, 7 Mar 2003 02:37:06 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:27795 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261421AbTCGHhF>; Fri, 7 Mar 2003 02:37:05 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
	<20030306222328.14b5929c.akpm@digeo.com>
	<Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
	<20030306233517.68c922f9.akpm@digeo.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 07 Mar 2003 16:45:10 +0900
In-Reply-To: <20030306233517.68c922f9.akpm@digeo.com>
Message-ID: <buoisuv1uyh.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
> All the arch/*/kernel/irq.c implementations are distressingly similar. 
> Andrey Panin did a bunch of work a while back to start consolidating the
> common code but it didn't quite get finished off.

Do you remember what was unfinished about it?  I tried his patch, and it
seemed to work fine; there were certainly still a few things left unmerged,
but it was a _huge_ improvement over the current state.

I never saw any responses to his messages on the lkml (except for mine!).

-Miles
-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
