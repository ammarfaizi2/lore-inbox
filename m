Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUC1A1T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUC1A1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:27:18 -0500
Received: from marco.bezeqint.net ([192.115.104.4]:14991 "EHLO
	marco.bezeqint.net") by vger.kernel.org with ESMTP id S261998AbUC1A1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:27:16 -0500
Date: Sun, 28 Mar 2004 02:27:05 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: swsusp-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was	Re: Your opinion on the merge?]]
Message-ID: <20040328002705.GA6634@luna.mooo.com>
Mail-Followup-To: swsusp-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <20040326222234.GE9491@elf.ucw.cz> <1080353285.9264.3.camel@calvin.wpcb.org.au>
	 <200403270337.48704.luke-jr@artcena.com> <20040327212946.GB295@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327212946.GB295@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 10:29:46PM +0100, Pavel Machek wrote:
> Hi!
> 
> On So 27-03-04 03:37:48, Luke-Jr wrote:
> > On Saturday 27 March 2004 02:08 am, Nigel Cunningham wrote:
> > > On Sat, 2004-03-27 at 10:22, Pavel Machek wrote:
> > > > You are right, that would be ugly. How is encryption supposed to work,
> > > > kernel asks you to type in a key?
> > >
> > > I haven't thought about the specifics there. Perhaps the plugin prompts
> > > for one, or perhaps it takes a lilo parameter? 
> > The only purpose I can think of for encryption would be so someone can't grab 
> > the HD and boot it on another PC or read the image directly.
> > Unless I'm missing something, that would imply that the key would need to be 
> > generated from a hardware profile (only creatable by root) somehow to 
> > restrict its readability to that one system.
> 
> Hmm, I do not see how hardware hash helps. When I can steal your hdd,
> there's good chance I can steal whole machine, too.
> 								Pavel

Which is probably much more probable. I have to admit I haven't heard
much of hard disk theft, but quite a bit of laptop theft, and when
swsusp comes to mind in this respect I would think the laptop thingy is
more of a problem.

> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> swsusp-devel mailing list
> swsusp-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/swsusp-devel
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
