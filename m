Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbUBFW4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUBFW4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:56:38 -0500
Received: from gprs148-92.eurotel.cz ([160.218.148.92]:3713 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265613AbUBFW4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:56:11 -0500
Date: Fri, 6 Feb 2004 23:55:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       Andi Kleen <ak@suse.de>, jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040206225535.GB539@elf.ucw.cz>
References: <20040127184029.GI32525@stop.crashing.org> <20040128165104.GC1200@elf.ucw.cz> <20040128170520.GI6577@stop.crashing.org> <20040128174402.GI340@elf.ucw.cz> <20040128175646.GJ6577@stop.crashing.org> <20040206223517.GD5219@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206223517.GD5219@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It's against 2.6 + -netpoll + Amit's patch.
> > 
> > But doesn't -mm have a kgdb over enet driver that does work?  It's just
> > not been ported to Amit's bits, right?
> 
> OK.  Based on this, and some other fixes, I've pushed my first cut of
> KGDB over ethernet.  It's not quite as robust as I'd like right now (I'm
> still getting it just-right for connecting live), and I've got some not
> quite finished improvements still locally, but it does work.

Is there way to get plain diff (against -mm or against Amit or
something?)

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
