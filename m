Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263418AbTCNQtD>; Fri, 14 Mar 2003 11:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263419AbTCNQtC>; Fri, 14 Mar 2003 11:49:02 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:44679 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263418AbTCNQtB>; Fri, 14 Mar 2003 11:49:01 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Mar 2003 09:09:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Never ever use word BitKeeper if Larry does not like you
In-Reply-To: <20030314163727.GE8937@work.bitmover.com>
Message-ID: <Pine.LNX.4.50.0303140856340.1903-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0303141120240.8584-100000@bushido>
 <1047659289.2566.109.camel@sisko.scot.redhat.com> <20030314163727.GE8937@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Larry McVoy wrote:

> But it can't read BK repositories in many cases.  We support compressed
> repositories, it can't read those.  We support many corner cases which
> SCCS didn't handle, it can't read those.  It can't reproduce all of the
> extensions that we have added.  In other words, saying what Pavel has
> is like BitKeeper is like saying cat is like Word because they both read
> data off of disk.
>
> That's the whole point.  If we sit back and let people think that he has
> something remotely similar to BK, it devalues BitKeeper in the mind of
> those people.  Since this is a very complex system with lots of subtle
> features, people easily get confused.  What Pavel has doesn't approach
> the functionality of CVS, let alone BitKeeper, yet he is describing it
> as a BitKeeper clone.  If we allow that, we're just shooting our brand
> name dead.

Ok, let's try again. Because honestly I'm pretty sick of this BK saga on
lkml. It's maybe time to understand if people here is against Larry or
against the BK license itself. It seems to me that there's the request of
a read-only tool that is able to read BK repositories to fetch the latest
kernel trees. I proposed before to Larry and to lkml to have Larry to
release a read-only ( read-only here means, able only to fetch sources and
related information ) BK binary under different licensing. Why this
couldn't solve the problem if Larry and the anti-BK movement will find an
agreement on the license ? Larry, is it possible to release such tool
under a less strict license ?




- Davide

