Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWBAEEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWBAEEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWBAEEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:04:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:41664 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964894AbWBAEEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:04:02 -0500
Date: Tue, 31 Jan 2006 20:03:36 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [GIT PATCH] PCI patches for 2.6.16-rc1
Message-ID: <20060201040336.GA26107@suse.de>
References: <20060201020437.GA20719@kroah.com> <Pine.LNX.4.64.0601311813400.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601311813400.7301@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 06:16:43PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 31 Jan 2006, Greg KH wrote:
> > 
> > linas:
> >       PCI Hotplug: PCI panic on dlpar add (add pci slot to running partition)
> >       PCI Hotplug/powerpc: module build break
> > 
> > linas@austin.ibm.com:
> >       powerpc/PCI hotplug: remove rpaphp_find_bus()
> >       powerpc/PCI hotplug: merge config_pci_adapter
> 
> Looks like Linas Vepstas doesn't have a good email address in his From: 
> fields.. As a result, the logs are nasty. 
> 
> Linas - could you _please_ fix your email setup, of if your email setup is 
> good, could whoever added the bogus "From: " line to the email please NOT 
> DO THAT HORRIBLE THING?

At least he put a valid email address in there, it used to just bounce
to a non-existant domain :(

> Greg, if you notice things like this, can you fix them up or bounce them 
> back to the author? Yeah, I let mistakes get through too, so I shouldn't 
> throw stones, but it's just so much _nicer_ if things look nice in the 
> logs etc, so I try to catch it when I can..

Sorry about that, I should have caught this.

thanks,

greg k-h
