Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUCWXpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbUCWXpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:45:21 -0500
Received: from gprs214-90.eurotel.cz ([160.218.214.90]:57477 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262915AbUCWXpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:45:12 -0500
Date: Wed, 24 Mar 2004 00:44:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jonathan Sambrook <swsusp@hmmn.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040323234449.GM364@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <1080081653.22670.15.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080081653.22670.15.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I'd hate
> > 
> > Nov 10 00:37:51 amd kernel: Buffer I/O error on device sr0, logical block 842340
> > Nov 10 00:37:53 amd kernel: end_request: I/O error, dev sr0, sector 6738472
> > 
> > to be obscured by progress bar.
> 
> So why aren't you arguing against bootsplash too? That definitely
> obscures such an error :> Of course we could argue that such an error
> shouldn't happen and/or will be obvious via other means (assuming it
> indicates hardware failure).

Of course I *am* against bootsplash. Unfortunately I've probably lost
that war already. But at least it is not in -linus tree (and that's
what I use anyway) => I gave up with bootsplash-equivalents, as long
as they don't come to linus.

[And I believe Linus would shoot down bootsplash-like code, anyway.]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
