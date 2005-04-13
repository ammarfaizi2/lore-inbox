Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVDMJt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVDMJt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVDMJt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:49:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15275 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261283AbVDMJtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:49:17 -0400
Date: Wed, 13 Apr 2005 11:49:16 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413094916.GR16489@pasky.ji.cz>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <20050413103521.D1798@flint.arm.linux.org.uk> <20050413103852.E1798@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413103852.E1798@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Apr 13, 2005 at 11:38:52AM CEST, I got a letter
where Russell King <rmk+lkml@arm.linux.org.uk> told me that...
> On Wed, Apr 13, 2005 at 10:35:21AM +0100, Russell King wrote:
> > On Mon, Apr 11, 2005 at 03:57:58PM +0200, Petr Baudis wrote:
> > >   here goes git-pasky-0.3, my set of patches and scripts upon
> > > Linus' git, aimed at human usability and to an extent a SCM-like usage.
> > 
> > I tried this today, applied my patch for BE<->LE conversions and
> > glibc-2.2 compatibility (attached, still requires cleaning though),
> > and then tried git pull.  Umm, whoops.
> 
> Oh, and the other thing is:
> 
> $ git pull
> 
> GNU Interactive Tools 4.3.20 (armv4l-rmk-linux-gnu), 20:02:38 Mar  7 2001
> GIT is free software; you can redistribute it and/or modify it under the
> terms of the GNU General Public License as published by the Free Software
> Foundation; either version 2, or (at your option) any later version.
> Copyright (C) 1993-1999 Free Software Foundation, Inc.
> Written by Tudor Hulubei and Andrei Pitis, Bucharest, Romania
> 
> git: fatal error: `chdir' failed: permission denied.
> 
> "git" already exists as a command from about 4 years ago.  Can we have
> less TLAs for commands please?  That namespace is rather over-used and
> collision-prone.

I've already noticed GNU interactive tools (googling for git), but it's
Linus' choice of name.  Alternative suggestions welcomed. What about
'gt'? ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
