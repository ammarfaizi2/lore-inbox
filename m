Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbSJAHqf>; Tue, 1 Oct 2002 03:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261516AbSJAHqf>; Tue, 1 Oct 2002 03:46:35 -0400
Received: from 62-190-218-226.pdu.pipex.net ([62.190.218.226]:772 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261514AbSJAHqe>; Tue, 1 Oct 2002 03:46:34 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210010800.g9180Ip4000313@darkstar.example.net>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
To: devilkin-lkml@blindguardian.org (DevilKin)
Date: Tue, 1 Oct 2002 09:00:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210010939.53707.devilkin-lkml@blindguardian.org> from "DevilKin" at Oct 01, 2002 09:39:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And if it wasn't clear to the non-2.5-development people out there, yes
> > you _should_ also test this code out even before the freeze. The IDE layer
> > shouldn't be all that scary any more, and while there are still silly
> > things like trivially non-compiling setups etc, it's generally a good idea
> > to try things out as widely as possible before it's getting too late to
> > complain about things..
> 
> Basically: I would _love_ to test this kernel on my laptop here, but - 
> unfortunately - i need the laptop for my work. Which means i need it to work.
> 
> So how much chance IS there to trash the filesystems? I guess a lot of ppl 
> like me are just waiting to test it out, but aren't willing to screw their 
> systems over it...

There is not much chance.

The only thing that can be guaranteed is that if nobody tests 2.5.x out, then 2.6.x will definitely have trivial bugs in it.

John.
