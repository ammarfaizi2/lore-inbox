Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKQHys>; Fri, 17 Nov 2000 02:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbQKQHyi>; Fri, 17 Nov 2000 02:54:38 -0500
Received: from dillweed.dsl.xmission.com ([166.70.14.212]:26465 "HELO
	winder.codepoet.org") by vger.kernel.org with SMTP
	id <S129132AbQKQHyT>; Fri, 17 Nov 2000 02:54:19 -0500
Date: Fri, 17 Nov 2000 00:30:46 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6
Message-ID: <20001117003046.A16984@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10011161832460.803-100000@penguin.transmeta.com> <20001116204510.B15356@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001116204510.B15356@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Thu, Nov 16, 2000 at 08:45:10PM -0700
X-Operating-System: Linux 2.2.17, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Nov 16, 2000 at 08:45:10PM -0700, Jeff V. Merkey wrote:
> > 
> >  - pre6:
> >     - Intel: start to add Pentium IV specific stuff (128-byte cacheline
> >       etc)
> >     - David Miller: search-and-destroy places that forget to mark us
> >       running after removing us from a wait-queue.
> Level I
> >     - me: NFS client write-back ref-counting SMP instability.
> >     - me: fix up non-exclusive waiters
> >     - Trond Myklebust: Be more careful about SMP in NFS and RPC code
> >     - Trond Myklebust: inode attribute update race fix
> >     - Charles White: don't do unaligned accesses in cpqarray driver.
> >     - Jeff Garzik: continued driver cleanup and fixes
> >     - Peter Anvin: integrate more of the Intel patches.
> >     - Robert Love: add i815 signature to the intel AGP support
> >     - Rik Faith: DRM update to make it easier to sync up 2.2.x
> >     - David Woodhouse: make old 16-bit pcmcia controllers work
> >       again (ie i82365 and TCIC)
> Level I
> 
> The list is getting shorter.  

WTF is "Level I" supposed to mean and why have you inserted it seemingly
randomly into the changelog and why are you telling the world about it?  I've
seen you do this several times and I am completely baffled.  Surely you have
some reason for wanting to share?

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org
--This message was written using 73% post-consumer electrons--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
