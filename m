Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268400AbTBYV3Q>; Tue, 25 Feb 2003 16:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268401AbTBYV3Q>; Tue, 25 Feb 2003 16:29:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:42674 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268400AbTBYV3N>;
	Tue, 25 Feb 2003 16:29:13 -0500
Date: Tue, 25 Feb 2003 13:36:13 -0800
From: Andrew Morton <akpm@digeo.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: fcorneli@elis.rug.ac.be, dan@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace PTRACE_READDATA/WRITEDATA, kernel 2.5.62
Message-Id: <20030225133613.320cf33a.akpm@digeo.com>
In-Reply-To: <3E5BA969.5000905@colorfullife.com>
References: <Pine.LNX.4.44.0302251113050.2572-100000@tom.elis.rug.ac.be>
	<3E5BA969.5000905@colorfullife.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 21:39:21.0472 (UTC) FILETIME=[5B8C1000:01C2DD16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> >http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.62/2.5.62-mm3/broken-out/ptrace-flush.patch
> >but it's getting fixed I hope.
> >  
> >
> This patch seems to be wrong.

Yes, it is wrong.  I discussed it with davem a while back and he was planning
on fixing it up for real.  I just keep the patch floating about as a reminder
that the thing which it doesn't fix needs fixing.

I'll update the changelog...


