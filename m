Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbUBPTss (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265853AbUBPTss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:48:48 -0500
Received: from gprs152-120.eurotel.cz ([160.218.152.120]:3713 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265852AbUBPTr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:47:59 -0500
Date: Mon, 16 Feb 2004 20:47:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       amitkale@emsyssoft.com
Subject: Re: [PATCH][6/6] A different KGDB stub
Message-ID: <20040216194724.GA322@elf.ucw.cz>
References: <20040212000408.GG19676@smtp.west.cox.net.suse.lists.linux.kernel> <p73wu6syf0n.fsf@verdi.suse.de> <20040212155055.GN19676@smtp.west.cox.net> <20040213040041.3e1ec2c2.ak@suse.de> <20040212162727.GO19676@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212162727.GO19676@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Part of why I'm trying to get this into -mm is so that someone who has
> > > the hw and knowledge can try and merge some of the things that the other
> > > stubs got right into the stub that every arch can use.
> > 
> > The kgdb stub in current -mm* does all the things I mentioned correctly.
> 
> Yes, and it also makes every arch implement the entire stub and provide
> its own serial driver.  Having said that, I'll try and pull out more of
> the things that the other stub gets right, but I don't have any x86_64
> hw (nor toolchain) so I can't test any of the x86_64 changes I make.

I think I can help with that...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
