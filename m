Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVDMLDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVDMLDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVDMLDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:03:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5053 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261307AbVDMLDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:03:06 -0400
Date: Wed, 13 Apr 2005 13:02:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Petr Baudis <pasky@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413110238.GA13865@elte.hu>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <20050413103521.D1798@flint.arm.linux.org.uk> <20050413103852.E1798@flint.arm.linux.org.uk> <20050413094916.GR16489@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413094916.GR16489@pasky.ji.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Petr Baudis <pasky@ucw.cz> wrote:

> > Oh, and the other thing is:
> > 
> > $ git pull
> > 
> > GNU Interactive Tools 4.3.20 (armv4l-rmk-linux-gnu), 20:02:38 Mar  7 2001
> > GIT is free software; you can redistribute it and/or modify it under the
> > terms of the GNU General Public License as published by the Free Software
> > Foundation; either version 2, or (at your option) any later version.
> > Copyright (C) 1993-1999 Free Software Foundation, Inc.
> > Written by Tudor Hulubei and Andrei Pitis, Bucharest, Romania
> > 
> > git: fatal error: `chdir' failed: permission denied.
> > 
> > "git" already exists as a command from about 4 years ago.  Can we have
> > less TLAs for commands please?  That namespace is rather over-used and
> > collision-prone.
> 
> I've already noticed GNU interactive tools (googling for git), but 
> it's Linus' choice of name.  Alternative suggestions welcomed. What 
> about 'gt'? ;-)

'gt' or 'gi' both sound fine - 'gi' being a bit faster to type ;-).  
(Even 'get' seems to be unused in the command namespace.)

	Ingo
