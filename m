Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbSLSUDn>; Thu, 19 Dec 2002 15:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbSLSUDn>; Thu, 19 Dec 2002 15:03:43 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64527 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266081AbSLSUDm>; Thu, 19 Dec 2002 15:03:42 -0500
Date: Thu, 19 Dec 2002 15:09:50 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: John Bradford <john@grabjohn.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dedicated kernel bug database
In-Reply-To: <200212191335.gBJDZRDL000704@darkstar.example.net>
Message-ID: <Pine.LNX.3.96.1021219150117.29410B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, John Bradford wrote:

> Following on from yesterday's discussion about there not being much
> interaction between the kernel Bugzilla and the developers, I began
> wondering whether Bugzilla might be a bit too generic to be suited to
> kernel development, and that maybe a system written from the ground up
> for reporting kernel bugs would be better?
> 
> I.E. I am prepared to write it myself, if people think it's
> worthwhile.

Hopefully you could make it more generic than just for kernel bugs.
Ideally it would be nice to be able to have both an interactive submission
and a way to mail a version number and get back a questionare to fill in
and resubmit. This allows for a custom form for some versions, as well as
another mail back listing known bugs fixed in later versions, to avoid
reporting fixed bugs.

I'm not sure if it would be possible to make a frontend to bugzilla, I'm
not thrilled with the whole thing, but I have no illusions of having
enough free time to tackle anything that large.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

