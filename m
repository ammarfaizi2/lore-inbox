Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKQIQe>; Fri, 17 Nov 2000 03:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129150AbQKQIQY>; Fri, 17 Nov 2000 03:16:24 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:13282 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129130AbQKQIQQ>; Fri, 17 Nov 2000 03:16:16 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Erik Andersen <andersen@codepoet.org>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 17 Nov 2000 00:30:59 -0800 (PST)
Subject: Re: test11-pre6
In-Reply-To: <20001117003046.A16984@codepoet.org>
Message-ID: <Pine.LNX.4.21.0011170030140.20185-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

he flags what he considers 'critical fixes' with the level 1 tag
(something about them being level 1 problems or something like that)

David Lang

On Fri, 17 Nov 2000, Erik Andersen wrote:

> Date: Fri, 17 Nov 2000 00:30:46 -0700
> From: Erik Andersen <andersen@codepoet.org>
> To: Jeff V. Merkey <jmerkey@vger.timpanogas.org>
> Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: test11-pre6
> 
> On Thu Nov 16, 2000 at 08:45:10PM -0700, Jeff V. Merkey wrote:
> > > 
> > >  - pre6:
> > >     - Intel: start to add Pentium IV specific stuff (128-byte cacheline
> > >       etc)
> > >     - David Miller: search-and-destroy places that forget to mark us
> > >       running after removing us from a wait-queue.
> > Level I
> > >     - me: NFS client write-back ref-counting SMP instability.
> > >     - me: fix up non-exclusive waiters
> > >     - Trond Myklebust: Be more careful about SMP in NFS and RPC code
> > >     - Trond Myklebust: inode attribute update race fix
> > >     - Charles White: don't do unaligned accesses in cpqarray driver.
> > >     - Jeff Garzik: continued driver cleanup and fixes
> > >     - Peter Anvin: integrate more of the Intel patches.
> > >     - Robert Love: add i815 signature to the intel AGP support
> > >     - Rik Faith: DRM update to make it easier to sync up 2.2.x
> > >     - David Woodhouse: make old 16-bit pcmcia controllers work
> > >       again (ie i82365 and TCIC)
> > Level I
> > 
> > The list is getting shorter.  
> 
> WTF is "Level I" supposed to mean and why have you inserted it seemingly
> randomly into the changelog and why are you telling the world about it?  I've
> seen you do this several times and I am completely baffled.  Surely you have
> some reason for wanting to share?
> 
>  -Erik
> 
> --
> Erik B. Andersen   email:  andersee@debian.org
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.2

iQEVAwUBOhTszD7msCGEppcbAQFNgwgAisbSnToAbGxSXqeD8zw/hDqiSg3Fj8Wx
uLjTZTJqv7XHPQSoaHzXuguBUr9t6OD+hmAiIhcWZpZ5C1RysWH1tRnQfdQRBe7N
Sca1iO4RBvN5jcZPwgX/+ztBrwtntBVjvlKE4EvZICuhHXAqyrnwNPOXOI2b+jju
QJXtZGr1Flhj1FK8kzNxr+iXFw9QQufkRO/kmcMQcUFf3syEfYcSMKR1eg74Yn13
PYL4EwfPGVBQr1jOSuxOI+8G450QFSYQL+eHCRH91C6uSHXEhgP6JiJYLlMulJya
5Ynl+j1vQ61HUa5/yAVgXG5i2tiY/sPyHYkDG7+M21PSoE80EOhO9Q==
=VdLu
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
