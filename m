Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVAGHfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVAGHfP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVAGHfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:35:14 -0500
Received: from ngate.noida.hcltech.com ([202.54.110.230]:26091 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S261302AbVAGHe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:34:58 -0500
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB0342D580@exch-03.noida.hcltech.com>
From: "Bhupesh Kumar Pandey, Noida" <bhupeshp@noida.hcltech.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Help regarding PCI Express hot Plug functionality in kernel 2
	 .6.8
Date: Fri, 7 Jan 2005 13:02:03 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Actually there are three thing, which I want to verify
	1. It has support for Hotplug of FC-HBA on PCI Express
	2. DISK(mainly iSCSI) addition to FC-SAN 
	3. PnP of Disk(mainly iSCSI) recognition by iSCSI Target(Including
FC side and iSCSI side)
And what is the information flow, how it works and what document and driver
code I should study.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Thanks and Best Regards
Bhupesh Kumar Pandey


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Friday, January 07, 2005 12:53 PM
To: Bhupesh Kumar Pandey, Noida
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help regarding PCI Express hot Plug functionality in kernel 2
.6.8

On Fri, Jan 07, 2005 at 12:44:05PM +0530, Bhupesh Kumar Pandey, Noida wrote:
>  
> Hi all,
> Please help me in investigating linux kernel 2.6.8 fot its hotplugging 
> support on PCI Express bus.
> Is it support this and I not the what are the limitations and problems.

Yes it supports it.  It should work just fine.  If not, please let us know
any problems you have.

thanks,

greg k-h
