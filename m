Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUA3QdT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUA3QdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:33:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:10186 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261872AbUA3QdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:33:18 -0500
Date: Fri, 30 Jan 2004 08:33:16 -0800
From: Greg KH <greg@kroah.com>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Matthew Wilcox <willy@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040130163316.GA4637@kroah.com>
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com> <20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk> <20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401290802370.689@home.osdl.org> <20040129180951.GA5681@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129180951.GA5681@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 10:09:52AM -0800, Greg KH wrote:
> On Thu, Jan 29, 2004 at 08:05:52AM -0800, Linus Torvalds wrote:
> > 
> > That said, this patch looks perfectly acceptable to me. With some testing, 
> > I'd take it through Greg or -mm.
> 
> It's looking much better.  But I _really_ want to actually test this on
> real hardware.  As no one is shipping PCI Express hardware yet, there is
> no rush to get this patch into the kernel tree.

Also, can someone from Intel test out Matthew's patch to make sure it
works properly for them on their hardware?  It's much cleaner than the
last patch submitted by you all :)

thanks,

greg k-h
