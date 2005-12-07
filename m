Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVLGBl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVLGBl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVLGBl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:41:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:25524 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965044AbVLGBl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 20:41:28 -0500
Date: Tue, 6 Dec 2005 17:41:02 -0800
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] x86 PCI domain support
Message-ID: <20051207014102.GA19170@suse.de>
References: <20051203013904.GA2560@havoc.gtf.org> <20051203031533.GB14247@wotan.suse.de> <4391FC0A.9040202@pobox.com> <20051207003922.GA18528@kroah.com> <20051207013201.GZ11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207013201.GZ11190@wotan.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 02:32:02AM +0100, Andi Kleen wrote:
> On Tue, Dec 06, 2005 at 04:39:22PM -0800, Greg KH wrote:
> > On Sat, Dec 03, 2005 at 03:11:54PM -0500, Jeff Garzik wrote:
> > > The first two patches could go in immediately, the last should probably 
> > > wait a bit...
> > 
> > What is the rush?  These seem pretty late for the -rc series :)
> > 
> > I'll send them in after 2.6.15 is out, is that ok?
> 
> It's ok, but the two related workaround patches I posted earlier should
> go into .15 (because they fix broken boot on some machines) 

Ok, that's fine.  Thanks for fixing those issues, I appreciate it.

greg k-h
