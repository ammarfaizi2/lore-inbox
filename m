Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVCVHzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVCVHzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVCVHzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:55:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:32979 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262491AbVCVHzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:55:02 -0500
Date: Mon, 21 Mar 2005 23:21:02 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, rjw@sisk.pl, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322072102.GA16205@kroah.com>
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503212343.31665.rjw@sisk.pl> <20050321160306.2f7221ec.akpm@osdl.org> <20050322004456.GB1372@elf.ucw.cz> <20050321170623.4eabc7f8.akpm@osdl.org> <20050322013535.GA1421@elf.ucw.cz> <20050321175232.34d93a13.akpm@osdl.org> <20050322020738.GA1628@elf.ucw.cz> <20050321182733.6a7e10f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321182733.6a7e10f0.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 06:27:33PM -0800, Andrew Morton wrote:
> OK, well unless someone has objections I'll just send all these
> 
> swsusp-add-missing-refrigerator-calls.patch
> suspend-to-ram-update-videotxt-with-more-systems.patch
> pm-remove-obsolete-pm_-from-vtc.patch
> swsusp-small-updates.patch
> swsusp-1-1-kill-swsusp_restore.patch
> fix-pm_message_t-in-generic-code.patch
> fix-u32-vs-pm_message_t-in-usb.patch
> more-pm_message_t-fixes.patch
> fix-u32-vs-pm_message_t-confusion-in-oss.patch
> fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
> fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
> fix-u32-vs-pm_message_t-confusion-in-mmc.patch
> fix-u32-vs-pm_message_t-confusion-in-serials.patch
> fix-u32-vs-pm_message_t-in-macintosh.patch
> fix-u32-vs-pm_message_t-confusion-in-agp.patch
> 
> to Linus when he reappears and then I'll duck for cover and let you guys
> sort it out ;)

No objection from me, that's probably the best way for this to get into
the tree.

thanks,

greg k-h
