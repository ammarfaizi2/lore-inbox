Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277842AbRJLTxd>; Fri, 12 Oct 2001 15:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277847AbRJLTxX>; Fri, 12 Oct 2001 15:53:23 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:60142 "EHLO
	postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S277844AbRJLTxP>; Fri, 12 Oct 2001 15:53:15 -0400
Message-ID: <08a901c15356$a2a1f360$6502a8c0@aslab.com>
From: "Jeff Nguyen" <jeff@aslab.com>
To: "Joel Jaeggli" <joelja@darkwing.uoregon.edu>,
        "John J Tobin" <ogre@sirinet.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110121203220.7418-100000@twin.uoregon.edu>
Subject: Re: Dual Athlon XP 1800+ on Tyan Thunder K7 or Tiger MP anyone?
Date: Fri, 12 Oct 2001 12:46:50 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

512MB modules are built using either 128-Mbit DRAM
or 256-Mbit DRAM. The former has twice the number
of DRAM IC over the latter. Due to the higher density
DRAM, there is a significant increase in cost. Since
Corsair uses 256Mbit DRAM, their 512MB modules
cost a lot more.

When you see a much cheaper 512Mb modules, that is
because it is built using 128Mbit DRAM.

Jeff

----- Original Message -----
From: "Joel Jaeggli" <joelja@darkwing.uoregon.edu>
To: "John J Tobin" <ogre@sirinet.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, October 12, 2001 12:32 PM
Subject: Re: Dual Athlon XP 1800+ on Tyan Thunder K7 or Tiger MP anyone?


> On 11 Oct 2001, John J Tobin wrote:
>
> > On Thu, 2001-10-11 at 14:14, bill davidsen wrote:
> > > In article <1002667385.1673.129.camel@phantasy> rml@tech9.net wrote:
> > >
> > > >Completely Agreed.  I am thinking of getting a dual AMD system for
doing
> > > >more kernel work (tackle AMD and SMP).  My main machine is a P3 now.
> > >
> > > The issue right now may be RAM cost. I just bought 512MB PC133 for
> > > $140/GB, while "registered PC2100" memory is about $900 from the same
> > > source. I think that's what the Tiger wants, isn't it?
>
> registered ecc dimms from crucial and kingston valueram are barely more
> than non-registered parts... I see the 512MB kingston registered ecc ddram
> part for $220 from a large mailorder house. the same spec part from
> corsair is still $489 from the same vendor. given the headaches that
> result from having to debug problems/faulty dimms on a machine with 2GB of
> ram and the non-trivial engineering that went into getting 4 reasonably
> spaced ddr dimm sockets on the mainboard. I expect registered ecc dimms
> will be well worth it, if only so that you can rule out the memory as the
> culprit if you have certain kinds of issues...
>
> joelja
>
>
> > > --
> > > bill davidsen <davidsen@tmr.com>
> >
> > The Tyan Tiger and Thunder both take Registered DDR DIMMs. Though
> > anandtech got it running using only one pair of unregistered, other
> > combinations of unregistered failed to boot. There are also no SMP
> > athlon chipsets that use PC133.
> >
> >
> >
>
> --
> --------------------------------------------------------------------------
> Joel Jaeggli        joelja@darkwing.uoregon.edu
> Academic User Services      consult@gladstone.uoregon.edu
>      PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
> --------------------------------------------------------------------------
> It is clear that the arm of criticism cannot replace the criticism of
> arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
> the right, 1843.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

