Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268797AbUHLVKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268797AbUHLVKC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268787AbUHLVHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:07:50 -0400
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:40838 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268788AbUHLVFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:05:42 -0400
Date: Thu, 12 Aug 2004 23:04:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Disconnect <swsusp@gotontheinter.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Status with pmdisk/swsusp merge ?
Message-ID: <20040812210415.GB17113@elf.ucw.cz>
References: <1091679494.5225.186.camel@gaston> <Pine.LNX.4.50.0408051517141.6736-100000@monsoon.he.net> <20040808182234.GA620@elf.ucw.cz> <1092065741.4088.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092065741.4088.3.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I intend to try and merge my tree with Linus once he releases 2.6.8,
> > > modulo any bugs that crop up between now and then. Feel free to send me
> > > the patches to fix up ppc before then, and I will merge them as well.
> > 
> > Sounds good.
> > 
> > > As far as the device power management stuff goes, I'm wading through the
> > > discussion right now..
> > 
> > Hopefully we can at least switch to enums so that we clear any
> > confusion....

> ..And once thats done and the tree settles a bit I'll start working on
> the swsusp2 x86_64 port again. (Unless someone who understands that
> whole thing better wants to jump forward.)
> 
> FWIW I ported the 'old' pmdisk suspend code into swsusp2 and I can
> suspend, but I can't resume. I haven't got a serial port (its a "modern"
> laptop.. with parallel, etc but no serial..) so I'm also looking at
> netconsole, digging around for a line printer, etc..

Well, suspend is always easy :-)))))))))))))))))))).

You may want to use 8 leds on paralel port.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
