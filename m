Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVE0TPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVE0TPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVE0TMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:12:47 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:33299 "EHLO
	MMS2.broadcom.com") by vger.kernel.org with ESMTP id S262555AbVE0TJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:09:53 -0400
X-Server-Uuid: 1F20ACF3-9CAF-44F7-AB47-F294E2D5B4EA
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
From: "Michael Chan" <mchan@broadcom.com>
To: "John W. Linville" <linville@tuxdriver.com>
cc: "Christoph Hellwig" <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, jgarzik@pobox.com, lusinsky@broadcom.com
In-Reply-To: <20050527190000.GC11592@tuxdriver.com>
References: <04132005193844.8410@laptop> <04132005193844.8474@laptop>
 <20050421165956.55bdcb14.davem@davemloft.net>
 <20050527184750.GB11592@tuxdriver.com>
 <20050527185334.GA7417@infradead.org>
 <20050527190000.GC11592@tuxdriver.com>
Date: Fri, 27 May 2005 11:12:04 -0700
Message-ID: <1117217524.4310.1.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-WSS-ID: 6E89AFFC1VO2673885-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 15:00 -0400, John W. Linville wrote:
> On Fri, May 27, 2005 at 07:53:35PM +0100, Christoph Hellwig wrote:
> > On Fri, May 27, 2005 at 02:47:52PM -0400, John W. Linville wrote:
> 
> > > +	1600  NetXtreme BCM5752 Gigabit Ethernet PCI Express
> > 
> > I don't think you should mention "PCI Express" here.  That can trivially
> > befound it looking at the configuration header.
> 
> I'm just following what is at pciids.sourceforge.net.  Plus, it is
> already like that for nine other IDs:
> 
>         1659  NetXtreme BCM5721 Gigabit Ethernet PCI Express
>         1677  NetXtreme BCM5751 Gigabit Ethernet PCI Express
>         167d  NetXtreme BCM5751M Gigabit Ethernet PCI Express
>         167e  NetXtreme BCM5751F Fast Ethernet PCI Express
>         169d  NetLink BCM5789 Gigabit Ethernet PCI Express
>         16dd  NetLink BCM5781 Gigabit Ethernet PCI Express
>         16f7  NetXtreme BCM5753 Gigabit Ethernet PCI Express
>         16fd  NetXtreme BCM5753M Gigabit Ethernet PCI Express
>         16fe  NetXtreme BCM5753F Fast Ethernet PCI Express
> 
> The Broadcom guys can speak-up, but I figure they know if "PCI Express"
> is appropriate for their device... :-)
>
Yes, "PCI Express" is appropriate. Thanks John.

