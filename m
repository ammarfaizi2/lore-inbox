Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285043AbRLMTdv>; Thu, 13 Dec 2001 14:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285006AbRLMTdl>; Thu, 13 Dec 2001 14:33:41 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:54562 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S285043AbRLMTdf> convert rfc822-to-8bit; Thu, 13 Dec 2001 14:33:35 -0500
Date: Thu, 13 Dec 2001 17:39:19 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
cc: <andrea@suse.de>, <axboe@suse.de>, <gibbs@scsiguy.com>,
        <LB33JM16@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
In-Reply-To: <20011212.160631.14975630.davem@redhat.com>
Message-ID: <20011213173234.B1979-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Dec 2001, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Wed, 12 Dec 2001 18:22:30 +0100 (CET)
>
>    PCI was intended to be implemented as a LOCAL BUS with all agents on the
>    LOCAL BUS being able to talk with any other agent using a flat addressing
>    scheme. Your PCI thing does not look like true PCI to me, but rather like
>    some bad mutant that has every chance not to survive a long time.
>
> Intentions are neither here nor there.  PCI is MORE USEFUL, because
> you CAN do things like IOMMU's and treat PCI like a complete seperate
> I/O bus world.

But there are a couple of things you cannot do with PCI. For example, you
cannot mow the lawn with PCI. But since there is always room for
improvement... :-) :-)

  Gérard.

