Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWATTXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWATTXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWATTXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:23:09 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11241
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750807AbWATTXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:23:08 -0500
Date: Fri, 20 Jan 2006 11:23:08 -0800
From: Greg KH <greg@kroah.com>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.16-rc1
Message-ID: <20060120192307.GA7831@kroah.com>
References: <20060120190400.GA12894@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120190400.GA12894@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 11:04:00AM -0800, Greg KH wrote:
> Here are some small PCI patches against your latest git tree.  They have
> all been in the -mm tree for a while with no problems.
> 
> They do the following:
> 	- document some feature-removal things for the future
> 	- add support for amd pci hotplug devices to the shpchp driver.
> 	- fix bugs and update the ppc64 rpaphp pci hotplug driver.
> 	- add some new and remove some duplicate pci ids.
> 	- make it more obvious that some msi functions are really being
> 	  used.
> 
> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
> or if master.kernel.org hasn't synced up yet:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
> 
> The full patches will be sent to the linux-pci mailing list, if anyone
> wants to see them.

Oops, also sent them to the linux-kernel mailing list too, sorry about
that.

/me hits his patchbomb script with a big stick...
