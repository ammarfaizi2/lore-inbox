Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbTFSUc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbTFSUc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:32:59 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:5899 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265502AbTFSUcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:32:54 -0400
Date: Thu, 19 Jun 2003 16:39:53 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Larry McVoy <lm@bitmover.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: SCM domains [was Re: Linux 2.5.71]
In-Reply-To: <20030618043527.GA21723@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1030619163732.12043A-100000@gatekeeper.tmr.com>
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

It still makes sense to have a CNAME for bk.kernel.org to match the
others. Much easier to remember and guess; if you know one you can intuit
the others.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

