Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWHCWfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWHCWfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 18:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHCWfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 18:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:62080 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932534AbWHCWfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 18:35:15 -0400
Date: Thu, 3 Aug 2006 15:30:35 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060803223035.GA26366@kroah.com>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <44D26D87.2070208@vmware.com> <1154644383.23655.142.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154644383.23655.142.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 11:33:03PM +0100, Alan Cox wrote:
> Ar Iau, 2006-08-03 am 14:41 -0700, ysgrifennodd Zachary Amsden:
> > Hence my point follows.  Using source compiled with the kernel as a 
> > module does nothing to provide a stable interface to the backend 
> > hardware / hypervisor implementation.
> 
> Could have fooled me. It seems to work for the IBM Mainframe people
> really well. 

And the PowerPC hypervisor interface :)

Have you discussed this with those two groups to make sure you aren't
doing something that would merely duplicate what they have already done?

thanks,

greg k-h
