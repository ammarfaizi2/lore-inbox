Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbWHABJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWHABJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWHABJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:09:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54996 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030378AbWHABJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:09:34 -0400
Date: Tue, 1 Aug 2006 03:09:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hua Zhong <hzhong@gmail.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060801010918.GA1915@elf.ucw.cz>
References: <20060730230757.GA1800@elf.ucw.cz> <005101c6b4d2$f7506210$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005101c6b4d2$f7506210$493d010a@nuitysystems.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-07-31 11:55:58, Hua Zhong wrote:
> > > Suspend2 patch is open source. You can always take a look.
> > 
> > swsusp is open source. You can always take a look. And you 
> > can always submit a patch.
> > 
> > > Moreover, if someone claims suspend2 isn't ready for merge, or the
> > 
> > Moreover, if someone claims swsusp is broken, they should 
> > attach bugzilla id.
> 
> Pavel,
> 
> You can't blame me for not doing these things, because I am not a maintainer.
> However, you are, and you defend yourself so hard for that position, so if _you_ 
> don't do these things, people complain.

I have taken a look at suspend2 and decided I did not like it. (see
archives). If you think parts of suspend2 are useful (== fix problem
on hardware you have), separate them and submit them.

If you want to claim that swsusp is broken, you should attach bugzilla
ids. Anything else is unhelpful.

I'm maintainer, but that does not mean that I have every possible
notebook on earth.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
