Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285169AbRLMVHO>; Thu, 13 Dec 2001 16:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285183AbRLMVHE>; Thu, 13 Dec 2001 16:07:04 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:60972 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S285169AbRLMVG6> convert rfc822-to-8bit; Thu, 13 Dec 2001 16:06:58 -0500
Date: Thu, 13 Dec 2001 19:13:01 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
cc: <andrea@suse.de>, <axboe@suse.de>, <gibbs@scsiguy.com>,
        <LB33JM16@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
In-Reply-To: <20011213.123008.21927765.davem@redhat.com>
Message-ID: <20011213190118.D2184-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Dec 2001, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Thu, 13 Dec 2001 17:17:22 +0100 (CET)
>
>    PS: Don't take the wrong way my statements against Sun stuff. In fact, I
>        dislike almost everything that comes and came from them. :)
>
> Unfortunately the things you complain about are anything but Sun or
> Sparc specific.  PPC64, MIPS64, Alpha, HPPA, and probably others I
> have forgotten (oh yes and IA64 in the future if Intel gets their
> heads out of their asses) all have IOMMU mechanisms in their PCI
> controllers.

Might just be contagious brain disease. :)

> This disease may even some day infect x86 systems.  In fact
> technically it already has, most AMD chipsets use a slightly modified
> Alpha PCI controller which does have an IOMMU hidden deep down inside
> of it :-)
>
> Like I said before, the fact that PCI allows this to work is a feature
> that is actually better for PCI's relevance and longevity, not worse.
>
> Or do you suggest that it is wiser to use bounce buffering to handle
> 32-bit cards on systems with more than 4GB of ram? :-)  Using all
> 64-bit capable cards is not an answer, especially when the big
> advantage of PCI is how commoditized and flooded the market is with
> 32-bit cards.

If things happened this way for the last 20 years, then the typical CPU
nowaday would probably look like a 20 GHz Z80. :)

When I purchased my PIII 233 MHz 4 years ago, I thought that my next
system will be a full 64 bit system. Indeed I was dreaming. Btw, I donnot
consider an hybrid 32bit path / 64bit path system to be a 64 bit system.

I understand the deal between making money and doing things right. In the
job I earn from, the former obviously applies, but I didn't earn a single
euro-cent from free software. So, allow me, at least as long as this will
not be changed, not to agree with you here and stop the discussion as a
result.

  Gérard.

