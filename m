Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVCUSb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVCUSb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCUSb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:31:56 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:53552 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261374AbVCUSbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:31:55 -0500
Date: Mon, 21 Mar 2005 10:27:46 -0800
From: Greg KH <gregkh@suse.de>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, akpm@osdl.org,
       len.brown@intel.com, tony.luck@intel.com, dely.l.sy@intel.com
Subject: Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
Message-ID: <20050321182745.GA5201@suse.de>
References: <20050318133856.A878@unix-os.sc.intel.com> <20050319051331.GC21485@suse.de> <20050321100457.A4477@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321100457.A4477@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 10:04:57AM -0800, Rajesh Shah wrote:
> > 	- Are you wanting the acpi specific patches to go into the tree
> > 	  through the acpi developers?  How about the ia64 specific
> > 	  patches?
> 
> I honestly don't know what the best approach is here - what do you
> recommend? I did receive an email from Andrew indicating he wants
> to pick these up for the next mm. Perhaps the best thing is to
> let Andrew include the whole series after I've addressed all
> feedback and you, Tony, Len etc. all agree these are OK to go in.

That sounds like a fine plan to me.

thanks,

greg k-h
