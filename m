Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288005AbSBMRjF>; Wed, 13 Feb 2002 12:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSBMRiw>; Wed, 13 Feb 2002 12:38:52 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22224 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287939AbSBMRip>; Wed, 13 Feb 2002 12:38:45 -0500
Date: Wed, 13 Feb 2002 10:38:15 -0700
Message-Id: <200202131738.g1DHcF726164@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, akpm@zip.com.au, linux-kernel@vger.kernel.org,
        ralf@uni-koblenz.de
Subject: Re: [patch] printk and dma_addr_t
In-Reply-To: <20020213.033641.102576462.davem@redhat.com>
In-Reply-To: <20020213.013557.74564240.davem@redhat.com>
	<E16awZq-0004s4-00@the-village.bc.nu>
	<20020213.033641.102576462.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Wed, 13 Feb 2002 10:23:50 +0000 (GMT)
>    
>    So how do they modify the printf format rules in gcc ?
>    
> Because they can claim that they are part of the C environment, and
> for the most part they are right so their extensions go into gcc's
> magic list.
> 
> In fact I'd claim their case to be plugging holes in the standards
> specified set of printf format strings. :-)
> 
> Hey... we could "borrow" one of these printf format strings we
> don't have any need for in the kernel and pretend that is for
> "dma_addr_t". :-)

Eeeep! I know you put a smiley there, but don't even think that!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
