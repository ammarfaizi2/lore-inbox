Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUCSWRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUCSWRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:17:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:5292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263127AbUCSWRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:17:38 -0500
Date: Fri, 19 Mar 2004 14:13:19 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [0/3] Make pci resources show up in iomem/ioport on ia64
Message-ID: <20040319221319.GB14128@kroah.com>
References: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 11:50:24PM +0000, Matthew Wilcox wrote:
> 
> I decided to do one simple little thing -- make PCI device resources show
> up in /proc/iomem and /proc/ioport on ia64 just like they do on i386.
> Of course, I found two bugs in the process so we have three logically
> separate patches that I shall be sending in reply to this message.

I've applied all 3 of these patches, thanks.

greg k-h
