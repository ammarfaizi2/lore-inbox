Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266173AbSLSUPw>; Thu, 19 Dec 2002 15:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbSLSUPv>; Thu, 19 Dec 2002 15:15:51 -0500
Received: from [81.2.122.30] ([81.2.122.30]:63240 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266173AbSLSUPu>;
	Thu, 19 Dec 2002 15:15:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212192032.gBJKWSpe002662@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: davidsen@tmr.com (Bill Davidsen)
Date: Thu, 19 Dec 2002 20:32:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1021219150117.29410B-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Dec 19, 2002 03:09:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Following on from yesterday's discussion about there not being much
> > interaction between the kernel Bugzilla and the developers, I began
> > wondering whether Bugzilla might be a bit too generic to be suited to
> > kernel development, and that maybe a system written from the ground up
> > for reporting kernel bugs would be better?
> > 
> > I.E. I am prepared to write it myself, if people think it's
> > worthwhile.
> 
> Hopefully you could make it more generic than just for kernel bugs.

Well, my intention was to write it based around being used for kernel
bugs, and let others modify it for their needs, (and presumably
Bugzilla was based around being used for reporting bugs in a web
browser).

> Ideally it would be nice to be able to have both an interactive submission
> and a way to mail a version number and get back a questionare to fill in
> and resubmit. This allows for a custom form for some versions, as well as
> another mail back listing known bugs fixed in later versions, to avoid
> reporting fixed bugs.

Interesting - so the first stage in reporting a bug would be to select
the latest 2.4 and 2.5 kernels that you've noticed it in, and get a
list of known bugs fixed in those versions.  Also, if you'd selected
the maintainer, (from an automatically generated list from the
MAINTAINERS file), it could just search *their* changes in the changelog.

> I'm not sure if it would be possible to make a frontend to bugzilla, I'm
> not thrilled with the whole thing, but I have no illusions of having
> enough free time to tackle anything that large.

I'm prepared to have a go at it.  This _is_ my kind of area - most of
my income this year has come from writing web-based database code :-).

> Doing interesting things with little computers since 1979.

Were you doing boring things with large computers before then?  :-)
:-) :-).  Sorry, I'm being silly now :-).

John.
