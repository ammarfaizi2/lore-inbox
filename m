Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVAGGVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVAGGVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 01:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVAGGVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 01:21:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:10201 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261257AbVAGGVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 01:21:15 -0500
Date: Thu, 6 Jan 2005 22:21:04 -0800
From: Greg KH <greg@kroah.com>
To: "Bhupesh Kumar Pandey, Noida" <bhupeshp@noida.hcltech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help regarding PCI Express hot Plug functionality in kernel 2 .6.8
Message-ID: <20050107062104.GA24057@kroah.com>
References: <267988DEACEC5A4D86D5FCD780313FBB033EC250@exch-03.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB033EC250@exch-03.noida.hcltech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 10:30:47AM +0530, Bhupesh Kumar Pandey, Noida wrote:
> I don't have any idea about 2.6 series.
> I believe that in Kernel 2.6 the driver in the below mentioned is the same
> as the driver I am referring to.
> /usr/src/linux/drivers/pci/hotplug/pciehp
> So I want to know the functionality of hot plug support on PCI Express in
> Kernel 2.6.8. How the information flow and what are the limitations.

Why not try the driver out in 2.6.10 (as that's the most recent kernel)
and report any problems that you might have with it?  That would
probably be easier.

thanks,

greg k-h
