Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbUCMWW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUCMWVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:21:10 -0500
Received: from marco.bezeqint.net ([192.115.104.4]:37342 "EHLO
	marco.bezeqint.net") by vger.kernel.org with ESMTP id S263201AbUCMWUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:20:25 -0500
Date: Sun, 14 Mar 2004 00:19:39 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Dealing with swsusp vs. pmdisk
Message-ID: <20040313221939.GG5960@luna.mooo.com>
Mail-Followup-To: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20040312224645.GA326@elf.ucw.cz> <20040313004756.GB5115@thunk.org> <1079146273.1967.63.camel@gaston> <20040313123620.GA3352@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313123620.GA3352@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 01:36:21PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Pavel, what do you think of the swsusp2 patch, BTW?  My biggest
> > > complaint about it is that since it's maintained outside of the
> > > kernel, it's constantly behind about 0.75 revisions behind the latest
> > > 2.6 release.  The feature set of swsusp2, if they can ever get it
> > > completely bugfree(tm) is certainly impressive.
> > 
> > I'd like it to be merged upstream too.
> 
> Are we talking 2.6 or 2.7 here?

That would probably depend on which one is more stable, not only
features. AFAIK swsusp2 is quite stable barring problems with drivers
with faulty PM code (dri, usb, ...). What is the state of swsusp?

> -- 
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
