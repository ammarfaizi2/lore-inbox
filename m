Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVAGFDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVAGFDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 00:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVAGFDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 00:03:54 -0500
Received: from ngate.noida.hcltech.com ([202.54.110.230]:49849 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S261245AbVAGFDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 00:03:47 -0500
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB033EC250@exch-03.noida.hcltech.com>
From: "Bhupesh Kumar Pandey, Noida" <bhupeshp@noida.hcltech.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Help regarding PCI Express hot Plug functionality in kernel 2
	.6.8
Date: Fri, 7 Jan 2005 10:30:47 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi thanks a lot for a reply.
Actually I want to use hot plug feature of PCI Express for FC-HBA. I have
investigated for 2.4 kernels, but they do not support hot plug here.
I don't have any idea about 2.6 series.
I believe that in Kernel 2.6 the driver in the below mentioned is the same
as the driver I am referring to.
/usr/src/linux/drivers/pci/hotplug/pciehp
So I want to know the functionality of hot plug support on PCI Express in
Kernel 2.6.8. How the information flow and what are the limitations.
Please help me out and thanks in advance for your concern.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Thanks and Best Regards
Bhupesh Kumar Pandey

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Friday, January 07, 2005 12:17 AM
To: Bhupesh Kumar Pandey, Noida
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help regarding PCI Express hot Plug functionality in kernel
2.6.8

On Thu, Jan 06, 2005 at 11:43:59PM +0530, Bhupesh Kumar Pandey, Noida wrote:
> hi all,
> Please help me regarding PCI Express hot Plug functionality in kernel
2.6.8.

What is not working for you?

Also, please read REPORTING-BUGS in the kernel source tree for how to
report an issue properly.

thanks,

greg k-h
