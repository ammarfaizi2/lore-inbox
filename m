Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVAJHMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVAJHMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 02:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVAJHMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 02:12:52 -0500
Received: from ngate.noida.hcltech.com ([202.54.110.230]:58848 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S262128AbVAJHMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 02:12:50 -0500
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB03500DB7@exch-03.noida.hcltech.com>
From: "Bhupesh Kumar Pandey, Noida" <bhupeshp@noida.hcltech.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: RE: regarding hotpluggable devices adn linux kernel
Date: Mon, 10 Jan 2005 12:39:56 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hotplug of FC-HBA on PCI Express bus and PnP of SCSI disk".


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Thanks and Best Regards
Bhupesh Kumar Pandey


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Monday, January 10, 2005 12:35 PM
To: Bhupesh Kumar Pandey, Noida
Cc: linux-kernel@vger.kernel.org
Subject: Re: regarding hotpluggable devices adn linux kernel

On Mon, Jan 10, 2005 at 12:19:21PM +0530, Bhupesh Kumar Pandey, Noida wrote:
>  
> Actually I want to know the how hotplugging works under 2.6 and what 
> is the information flow and how a user can do this.

Hotplug what?  That's a _very_ general term.  Hotplug CPU?  Hotplug Memory?
Hotplug SCSI disk?  Hotplug USB device?  Hotplug keyboard?
Hotplug PCI device?  Hotplug IEEE1394 device?  Hotplug PCMCIA device?
The userspace /sbin/hotplug script?  The linux-hotplug script package?
and so on...

They all work differently, as they are all different things.

> Secondly is it support PnP of iSCSI disks? If yes then it has support 
> in kernel or any patch is nedded? If no then what are the problems.

I do not know anything about iSCSI, sorry.  Try asking on the linux-scsi
mailing list.

greg k-h
