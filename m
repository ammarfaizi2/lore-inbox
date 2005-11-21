Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVKUVfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVKUVfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVKUVfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:35:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:61157 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750902AbVKUVfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:35:09 -0500
Date: Mon, 21 Nov 2005 13:33:39 -0800
From: Greg KH <gregkh@suse.de>
To: "Jordan, William P" <William.Jordan@unisys.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in drivers/pci/hotplug/ibmphp_pci.c
Message-ID: <20051121213339.GC17152@suse.de>
References: <5E735516D527134997ABD465886BBDA61AC13E@USTR-EXCH5.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E735516D527134997ABD465886BBDA61AC13E@USTR-EXCH5.na.uis.unisys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 10:09:36AM -0500, Jordan, William P wrote:
> 
> 
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Friday, November 18, 2005 8:14 PM
> > 
> > Yes it does look like that.  Does changing this solve a problem that
> you
> > have been seeing?
> 
> Actually, I am not running this code at all. I am just trying to
> understand PCI. While investigating how the IO base and IO limit
> registers are used, I noticed this instance where it was used
> inconsistently. I can resubmit it if you like, but I cannot vouch for
> the patch.

Yes, please resubmit it in the proper format as per
Documentation/SubmittingPatches.

thanks,

greg k-h
