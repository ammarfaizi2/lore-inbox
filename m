Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWAXVeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWAXVeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWAXVeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:34:44 -0500
Received: from devrace.com ([198.63.210.113]:54536 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1750743AbWAXVen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:34:43 -0500
Date: Tue, 24 Jan 2006 22:33:54 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Diego Calleja <diegocg@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to discover new Linux features (was: Re: Linux 2.6.16-rc1)
Message-ID: <20060124213354.GA2466@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Diego Calleja <diegocg@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <200601182323_MC3-1-B627-7710@compuserve.com> <81b0412b0601232316h6a26b083oab0b6d8de15e4c95@mail.gmail.com> <Pine.LNX.4.58.0601240712300.5978@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601240712300.5978@shark.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap, Tue, Jan 24, 2006 16:13:37 +0100:
> > >  Say you are comparing kernels 2.6.14 and 2.6.15, trying to see what
> > > is new.  Just do this:
> > >
> > >  1.  Copy a .config file into your 2.6.14 directory.
> > >
> > >  2.  Run "make oldconfig" there.  It doesn't really matter what
> > >      answers you give so long as it runs to completion.
> >
> > make it "make allconfig"
> 
> Are you suggesting a new make target?  'make help' lists
> allyesconfig, allnoconfig, or allmodconfig (in the all* group).
> 

...! allyesconfig, of course.

