Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282670AbRLKSzv>; Tue, 11 Dec 2001 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282540AbRLKSzm>; Tue, 11 Dec 2001 13:55:42 -0500
Received: from mustard.heime.net ([194.234.65.222]:18816 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S282525AbRLKSzg>; Tue, 11 Dec 2001 13:55:36 -0500
Date: Tue, 11 Dec 2001 19:54:49 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: possible bug with RAID
In-Reply-To: <Pine.LNX.4.33.0112111347330.7710-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0112111952430.1232-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it would be interesting to write a simple benchmark
> that simply reads a file at a fixed rate.  *that* would
> actually simulate your app.

sure. I'm using tux+wget for that. I were just playing around with dd

> sounds like a VM/balance problem.  you didn't mention which kernel
> you're using.

2.4.16 w/tux + xfs. The fs used on the raid vol is xfs

> > I tried to do the bechmark with the individual drives, and no problem
> > there...
>
> much less bandwidth, and therefore VM pressure.

ok
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


