Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284445AbRLMRZQ>; Thu, 13 Dec 2001 12:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284467AbRLMRZH>; Thu, 13 Dec 2001 12:25:07 -0500
Received: from mustard.heime.net ([194.234.65.222]:21983 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284464AbRLMRZC>; Thu, 13 Dec 2001 12:25:02 -0500
Date: Thu, 13 Dec 2001 18:24:13 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>, Tux mailing list <tux-list@redhat.com>
Subject: Re: [BUG?] RAID sub system / tux
In-Reply-To: <Pine.LNX.4.33.0112131217410.15231-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0112131819040.26829-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Just wanted to say I've reproduced the error in tux-D1.
> > > how about without tux?
> > >
> >
> > I don't know how to do an intensive read like that without tux.
> > Perhaps you've got an idea?
>
> why not apache?

I first tried, but it all somehow fucked up.

So I tried again - better this time. Same result as with Tux, just that
the system's idle. All the apache processes goes defunct, and the total
i/o as reported by vmstat is peaking at aouund 1000 blocks per sec. Not a
lot, really...

So sorry, Ingo and you other tux guys, it wasn't your fault.

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

