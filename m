Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVKQXzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVKQXzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVKQXzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:55:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:36536 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965142AbVKQXza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:55:30 -0500
Date: Thu, 17 Nov 2005 15:39:58 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <gregkh@suse.de>, Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [RFC][PATCH 6/6] PCI PM: pci_save/restore_state improvements
Message-ID: <20051117233957.GB10464@kroah.com>
References: <1132111902.9809.59.camel@localhost.localdomain> <20051116063125.GE31375@suse.de> <1132125965.3656.15.camel@localhost.localdomain> <20051116180655.GC6908@suse.de> <1132271430.3656.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132271430.3656.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 06:50:30PM -0500, Adam Belay wrote:
> 
> I'm probably going to regret this, but I'd be happy to take on any PCI
> PM subsystem bug reports.  Unless I forgot a register we need to
> restore, I'm not expecting this to cause too many problems.  A little
> time in -mm should shake out any issues out rather quickly.

Ok, respin them and I'll be glad to add them to my tree.

thanks,

greg k-h
