Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUA2SLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 13:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266253AbUA2SLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 13:11:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:49301 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266167AbUA2SJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 13:09:56 -0500
Date: Thu, 29 Jan 2004 10:09:52 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@colin2.muc.de>, Andrew Morton <akpm@osdl.org>, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040129180951.GA5681@kroah.com>
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com> <20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk> <20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401290802370.689@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401290802370.689@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 08:05:52AM -0800, Linus Torvalds wrote:
> 
> That said, this patch looks perfectly acceptable to me. With some testing, 
> I'd take it through Greg or -mm.

It's looking much better.  But I _really_ want to actually test this on
real hardware.  As no one is shipping PCI Express hardware yet, there is
no rush to get this patch into the kernel tree.

Bill Irwin and I are working on getting some PCI Express hardware to
test this patch out on.  We've been promised some for a while, hopefully
it turns up soon...

thanks,

greg k-h
