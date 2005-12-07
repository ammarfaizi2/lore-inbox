Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbVLGFaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVLGFaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 00:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVLGFaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 00:30:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932576AbVLGFaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 00:30:15 -0500
Date: Tue, 6 Dec 2005 21:23:27 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 0/3] x86 PCI domain support
Message-ID: <20051207052327.GA21229@kroah.com>
References: <20051203013904.GA2560@havoc.gtf.org> <20051203031533.GB14247@wotan.suse.de> <4391FC0A.9040202@pobox.com> <20051207003922.GA18528@kroah.com> <43964586.3080300@pobox.com> <20051207023305.GA19746@kroah.com> <43966117.9040700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43966117.9040700@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 11:12:07PM -0500, Jeff Garzik wrote:
> Greg KH wrote:
> >On Tue, Dec 06, 2005 at 09:14:30PM -0500, Jeff Garzik wrote:
> >
> >>Greg KH wrote:
> >>
> >>>On Sat, Dec 03, 2005 at 03:11:54PM -0500, Jeff Garzik wrote:
> >>>
> >>>
> >>>>The first two patches could go in immediately, the last should probably 
> >>>>wait a bit...
> >>>
> >>>
> >>>What is the rush?  These seem pretty late for the -rc series :)
> >>>
> >>>I'll send them in after 2.6.15 is out, is that ok?
> >>
> >>You were supposed to read my mind :)  "immediately" meant "ok for 
> >>upstream when -rc cycle closes" :)  The third patch I don't consider 
> >>ready for upstream, -rc or no.
> >
> >
> >Ok, thanks.  But I did just include the third patch in my tree, so it
> >will get tested in -mm.  If you don't want this to happen, just let me
> >know and I'll drop it.
> 
> There's no ultimate harm in it, because nothing turns on 
> CONFIG_PCI_DOMAINS in x86[-64] yet...

I'm guessing that will be a follow-on patch?  :)

greg k-h
