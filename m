Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTL0Gvx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 01:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbTL0Gvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 01:51:53 -0500
Received: from [64.65.177.98] ([64.65.177.98]:17397 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S264330AbTL0Gvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 01:51:51 -0500
Subject: Re: 2.7 (future kernel) wish
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: "David B. Stevens" <dsteven3@maine.rr.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FECCAF9.7070209@maine.rr.com>
References: <200312232342.17532.josh@stack.nl>
	 <20031226233855.GA476@hh.idb.hist.no>  <3FECCAF9.7070209@maine.rr.com>
Content-Type: text/plain
Message-Id: <1072507896.27022.226.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Dec 2003 22:51:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-26 at 15:57, David B. Stevens wrote:
> While I agree that the kernel should provide decent error handling and 
> reporting I still have to ask questions about what is reasonable.
> 
> What does that other OS do when you pull a USB stick out?  What do you 
> think the kernel should do?  Why don't the applications operating on the 
> data take better care of handling error conditions?
> 
> I don't have one here to try, but at some point the (ab)user needs to 
> take a bit of the heat for his or her action(s) or lack thereof.
> 
> After all you could just reach in your case and rip out the IDE or SCSI 
> cables.  Bet that leads to all kinds of stuff (tm).
> 
> Cheers,
>   Dave
> 
> 
> Helge Hafting wrote:
> 
> >On Tue, Dec 23, 2003 at 11:42:17PM +0100, Jos Hulzink wrote:
> >  
> >
> >>Hi,
> >>
> >>First of all... Compliments about 2.6.0. It is a superb kernel, with very few 
> >>serious bugs, and for me it runs stable like a rock from the very first 
> >>moment.
> >>
> >>As an end user, Linux doesn't give me a good feeling on one particular item 
> >>yet: Error handling. 
> >>
> >>What do I mean ? Well... for example: Pull out your USB stick with a mounted 
> >>fs on it. 
> >>    
> >>
> >
> >You aren't supposed to do that.  If you want to pull devices like that,
> >with no warning, access them in other ways than mounting.  
> >mtools are nice when you don't want to mount/umount floppies - a
> >similiar approach should work for usb sticks too.
> >
> >
> >
> >Helge Hafting
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >

Sometimes Windows 2k or XP dump (BSOD), or maybe you just get an error. 

-- 
VB programmers ask why no one takes them seriously, 
it's somewhat akin to a McDonalds manager asking employees 
why they don't take their 'career' seriously.

