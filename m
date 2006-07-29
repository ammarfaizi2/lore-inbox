Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWG2Xrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWG2Xrv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWG2Xrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:47:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24804 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750804AbWG2Xrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:47:51 -0400
Date: Sun, 30 Jul 2006 01:47:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hua Zhong <hzhong@gmail.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060729234736.GA2060@elf.ucw.cz>
References: <200607292319.31935.rjw@sisk.pl> <005701c6b359$dacc6f50$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005701c6b359$dacc6f50$0200a8c0@nuitysystems.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Moreover, if the swsusp's resume doesn't work for you and 
> > suspend2's resume does, this probably means that suspend2 
> > contains some driver fixes that haven't been submitted for merging.
> 
> This statement worries me for several reasons.
> 
> First, I've seen repeatedly blame for "drivers". People might buy it if there was not a working suspend2. I never saw Nigal blame
> drivers; instead he makes sure to provide working code. In the end, users want a working suspend, and that's what counts.
>

You seem to be claiming that swsusp is broken, but I do not remember
any bugreport from you. So... either provide bugzilla #, or stop
spreading FUD.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
