Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKIA3x>; Wed, 8 Nov 2000 19:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKIA3n>; Wed, 8 Nov 2000 19:29:43 -0500
Received: from ocmax10-248.dialup.optusnet.com.au ([198.142.43.248]:27912 "HELO
	tae-bo.generica.dyndns.org") by vger.kernel.org with SMTP
	id <S129112AbQKIA31>; Wed, 8 Nov 2000 19:29:27 -0500
Date: Thu, 9 Nov 2000 11:35:03 +1100 (EST)
From: Brett <bpemberton@dingoblue.net.au>
To: David Ford <david@linux.com>
cc: David Feuer <David_Feuer@brown.edu>, linux-kernel@vger.kernel.org
Subject: Re: pcmcia
In-Reply-To: <3A09E8E6.2118280D@linux.com>
Message-ID: <Pine.LNX.4.21.0011091131240.9217-100000@tae-bo.generica.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

I don't know if this counts as a _problem_, 
but I need to enable pci support to get pcmcia/cardbus activated.
Is this really necessary ?? My current kernels work fine without pci
support, and sure, enabling it won't hurt, just make the kernel bigger,
but why is the restriction there ?

Also, what has happened to the i82365 support that I need ? 
Its nicely commented out in drivers/net/pcmcia/Config.in

I remember everything working fine up until about test3/4, since then I've
had to revert to the pcmcia-cs package.

Just wondering whats going on ?

	/ Brett

On Wed, 8 Nov 2000, David Ford wrote:
>
> With a few exceptions, it should work.  The problematic systems are few.
> 
> -d
> 
> David Feuer wrote:
> 
> > What is the current status of PC-card support?  I've seen ominous signs on
> > this list about the state of support....  I have a laptop with a PCMCIA
> > network card (a 3com thing). Will it work?
> 
> --
> "The difference between 'involvement' and 'commitment' is like an
> eggs-and-ham breakfast: the chicken was 'involved' - the pig was
> 'committed'."
> 
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
