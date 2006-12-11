Return-Path: <linux-kernel-owner+w=401wt.eu-S1762255AbWLKUVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762255AbWLKUVx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762990AbWLKUVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:21:52 -0500
Received: from ns.suse.de ([195.135.220.2]:50069 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762255AbWLKUVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:21:52 -0500
Date: Mon, 11 Dec 2006 12:21:32 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olaf Hering <olaf@aepfle.de>, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211202131.GA9868@kroah.com>
References: <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org> <457DAF99.4050106@shadowen.org> <20061211195628.GA19889@aepfle.de> <Pine.LNX.4.64.0612111204010.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612111204010.12500@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 12:05:36PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Dec 2006, Olaf Hering wrote:
> > 
> > Quick, compile tested, patch below.
> 
> No. We don't do this. We don't add TOTAL CRAP to the kernel just because 
> somebody is being an idiot in user space.
> 
> This is definitely a user space bug. It was a serious bug before, it just 
> wasn't obvious.
> 
> The thing is, if anybody runs SLES, they expect support. That's what the 
> "E" in "Enterprise" means.
> 
> So I would suggest SLES now show that support by fixing THEIR BUG.

I agree, it's SuSE's bug, not the kernel's issue.

I'll take this off-list with the SuSE developers to get this fixed.

thanks,

greg k-h
