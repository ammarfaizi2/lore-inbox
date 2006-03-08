Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWCHW0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWCHW0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWCHW0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:26:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54029 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030237AbWCHW0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:26:54 -0500
Date: Wed, 8 Mar 2006 23:26:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060308222652.GR4006@stusta.de>
References: <20060306223545.GA20885@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306223545.GA20885@kroah.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 02:35:45PM -0800, Greg KH wrote:

> Here's a summary of the current state of the Linux PCI and PCI Hotplug
> subsystems as of 2.6.16-rc5
> 
> If the information in here is incorrect, or anyone knows of any
> outstanding issues not listed here, please let me know.
>...
> Was this summary useful for people?  Anything that I should add to it?

It is useful, but one thing seems to be missing:
Which patches do you intend to forward for 2.6.16 (if any)?

(pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch seems to
 be a candidate.)

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

