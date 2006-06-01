Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965320AbWFAVeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbWFAVeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965322AbWFAVeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:34:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:42416 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965320AbWFAVeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:34:00 -0400
Date: Thu, 1 Jun 2006 14:31:33 -0700
From: Greg KH <greg@kroah.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Bernhard Kaindl <bk@suse.de>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm2 -- PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
Message-ID: <20060601213133.GC18948@kroah.com>
References: <a44ae5cd0606010752n637c6411l805115f8170f0ebb@mail.gmail.com> <200606012045.29146.s0348365@sms.ed.ac.uk> <a44ae5cd0606011330w3158f00bwbe6119943bbc4e2@mail.gmail.com> <200606012155.16545.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606012155.16545.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 09:55:16PM +0100, Alistair John Strachan wrote:
> On Thursday 01 June 2006 21:30, Miles Lane wrote:
> > Yes, my machine is a dv1240us HP laptop.  The machine appears to be
> > working fine.  I haven't tested all the devices, but the ones I am
> > using regularly are all happy campers.
> 
> It seems many HP and Compaq notebooks that this problem; I've got the same 
> thing on my NC6000 and it works fine too. BIOS problem?
> 
> Andrew, I think this message should be silenced (or at least the note about 
> LKML) if there's no evidence of breakage. For the last LKML 4-5 reporters, 
> they reported no side-affects. At the very least, the message could be toned 
> down somewhat.

Bernhard put that message in there for a good reason, let's let him
decide if something needs to change or not.

thanks,

greg k-h
