Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVLGCk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVLGCk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 21:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVLGCk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 21:40:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:21452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964855AbVLGCk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 21:40:28 -0500
Date: Tue, 6 Dec 2005 18:33:05 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 0/3] x86 PCI domain support
Message-ID: <20051207023305.GA19746@kroah.com>
References: <20051203013904.GA2560@havoc.gtf.org> <20051203031533.GB14247@wotan.suse.de> <4391FC0A.9040202@pobox.com> <20051207003922.GA18528@kroah.com> <43964586.3080300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43964586.3080300@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 09:14:30PM -0500, Jeff Garzik wrote:
> Greg KH wrote:
> >On Sat, Dec 03, 2005 at 03:11:54PM -0500, Jeff Garzik wrote:
> >
> >>The first two patches could go in immediately, the last should probably 
> >>wait a bit...
> >
> >
> >What is the rush?  These seem pretty late for the -rc series :)
> >
> >I'll send them in after 2.6.15 is out, is that ok?
> 
> You were supposed to read my mind :)  "immediately" meant "ok for 
> upstream when -rc cycle closes" :)  The third patch I don't consider 
> ready for upstream, -rc or no.

Ok, thanks.  But I did just include the third patch in my tree, so it
will get tested in -mm.  If you don't want this to happen, just let me
know and I'll drop it.

thanks,

greg k-h
