Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVJRHbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVJRHbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbVJRHbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:31:06 -0400
Received: from waste.org ([216.27.176.166]:16773 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751456AbVJRHbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:31:04 -0400
Date: Tue, 18 Oct 2005 00:29:27 -0700
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ketchup+rt with ktimers added.
Message-ID: <20051018072927.GU26160@waste.org>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain> <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain> <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 02:45:27AM -0400, Steven Rostedt wrote:
> > > I didn't know about your repo directory.  Sorry, didn't have time to look
> > > too deep into this. I just did a few searches on the web and found
> > > different links scattered around.  I was just interested in the RT stuff,
> > > so I didn't go to deep.
> > >
> > > Actually, if you had a link to the repo from
> > > http://www.selenic.com/ketchup/ I would have found it.
> >
> > It's here:
> >
> > http://www.selenic.com/ketchup/wiki/
> 
> Ahh, I did see this. That word "Mercurial" scared me from looking further!

Scared? One of the many nice features of Mercurial is you can easily
grab a tarball of a given revision by clicking on one of the archive
links.

http://selenic.com/repo/ketchup/?cmd=archive;node=tip;type=bz2

I've added this snapshot link to the wiki. An actual release should be
appearing shortly.

-- 
Mathematics is the supreme nostalgia of our time.
