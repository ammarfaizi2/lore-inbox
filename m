Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbTFSU3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbTFSU3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:29:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:5131 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265435AbTFSU3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:29:44 -0400
Date: Thu, 19 Jun 2003 16:36:39 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Larry McVoy <lm@bitmover.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: SCM domains [was Re: Linux 2.5.71]
In-Reply-To: <20030618043527.GA21723@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1030619163421.12009A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jun 2003, Larry McVoy wrote:

> On Tue, Jun 17, 2003 at 09:11:07PM -0700, H. Peter Anvin wrote:
> > Followup to:  <20030618011455.GF542@hopper.phunnypharm.org>
> > By author:    Ben Collins <bcollins@debian.org>
> > In newsgroup: linux.dev.kernel
> > > > 
> > > > I have no problem setting up CNAMEs in kernel.org if people are OK with
> > > > it.  Setting up actual servers is another matter.
> > > 
> > > CNAMES on kernel.org would be perfect.
> > > 
> > 
> > So right now cvs, svn and bk all -> kernel.bkbits.net?
> 
> We only need cvs and svn; bk is hosted at linux.bkbits.net.

Why would you *not* have bk.kernel.org as a CNAME? For ease of memory,
etc, it makes sense to do that. If someone knows about cvs.kernel.org,
they are more likely to guess the bk address. And vice-versa, of course.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

