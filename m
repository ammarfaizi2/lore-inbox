Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVCERtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVCERtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVCERpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:45:41 -0500
Received: from 64-85-47-3.ip.van.radiant.net ([64.85.47.3]:11538 "EHLO
	vlinkmail") by vger.kernel.org with ESMTP id S261698AbVCERnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:43:32 -0500
Date: Sat, 5 Mar 2005 09:40:55 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050305174055.GB13104@kroah.com>
References: <20050304222146.GA1686@kroah.com> <20050305135917.GB6373@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305135917.GB6373@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 02:59:17PM +0100, Adrian Bunk wrote:
> On Fri, Mar 04, 2005 at 02:21:46PM -0800, Greg KH wrote:
> 
> > Anything else anyone can think of?  Any objections to any of these?
> > I based them off of Linus's original list.
> 
> Are these 100% fixed rules or just guidelines you use?

Guidelines of course :)

> An example that doesn't fit:
> 
> A patch of me to remove an unused function was accepted into 2.6.11 .
> Today, someone mailed that there's an external GPL'ed module that uses 
> this function.
> 
> A patch to re-add this function as it was in 2.6.10 does not fulfill 
> your criteria, but it is a low-risk way to fix a regression compared to 
> 2.6.10 .

Yes, I wouldn't have a problem with adding this kind of fix.  Do others
disagree?

thanks,

greg k-h
