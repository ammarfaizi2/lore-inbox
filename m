Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268270AbTB1X6R>; Fri, 28 Feb 2003 18:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTB1X6Q>; Fri, 28 Feb 2003 18:58:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45578 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268270AbTB1X6M>;
	Fri, 28 Feb 2003 18:58:12 -0500
Date: Fri, 28 Feb 2003 15:59:47 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.63
Message-ID: <20030228235947.GA29946@kroah.com>
References: <20030225011303.GA5182@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225011303.GA5182@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 05:13:03PM -0800, Greg KH wrote:
> Hi,
> 
> Here's some patches that clean up the remove logic a lot for the PCI
> hotplug drivers.  The main PCI patches were done by Russell King and
> Christoph Hellwig, and then I went and cleaned up the PCI Hotplug
> drivers a lot based on their changes.  I also fixed up some exit logic
> in the IBM PCI hotplug driver, as it was a mess.
> 
> Please pull from:  bk://kernel.bkbits.net/gregkh/linux/pci-2.5

I've merged with your latest tree again, and it's available at the above
place.  Could you please pull these changes?

thanks,

greg k-h
