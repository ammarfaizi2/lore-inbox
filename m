Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269204AbUIHX6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269204AbUIHX6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269209AbUIHX5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:57:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:35801 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269216AbUIHXyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:54:47 -0400
Date: Wed, 8 Sep 2004 16:50:46 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, jonsmirl@gmail.com
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040908235046.GB8361@kroah.com>
References: <20040908031537.92163.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908031537.92163.qmail@web14929.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 08:15:37PM -0700, Jon Smirl wrote:
> Greg, are you going to send pci-sysfs-rom-22.patch upstream? Or do I
> need to do it, if so how? Jesse's objection turned out to be a problem
> in another piece of code.

Ok, I've applied this to my kernel trees and it will show up in the next
-mm release.  Nice job everyone.

thanks,

greg k-h
