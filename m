Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUBKPxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUBKPxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:53:43 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:18951 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265825AbUBKPxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:53:42 -0500
Date: Wed, 11 Feb 2004 15:53:37 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Greg KH <greg@kroah.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Newest fbdev patch to go mainline.
In-Reply-To: <20040210190413.A8470@infradead.org>
Message-ID: <Pine.LNX.4.44.0402111553220.21250-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have patches coming later in the day today.


On Tue, 10 Feb 2004, Christoph Hellwig wrote:

> On Tue, Feb 10, 2004 at 05:49:52PM +0000, James Simmons wrote:
> > Thats coming :-) The problem only showes itself with modular drivers 
> > correct. So I will submit patches for those first. I just wanted to polish 
> > off a few really tiny patches fist.
> 
> You just copletly b0rked up lifetime rules.  Please revert the sysfs patch
> and add it back when all drivers are fixed.  
> 
> 

