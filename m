Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277820AbRJLTad>; Fri, 12 Oct 2001 15:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277821AbRJLTaN>; Fri, 12 Oct 2001 15:30:13 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:237 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S277820AbRJLTaL>; Fri, 12 Oct 2001 15:30:11 -0400
Date: Fri, 12 Oct 2001 12:32:15 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: John J Tobin <ogre@sirinet.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon XP 1800+ on Tyan Thunder K7 or Tiger MP anyone?
In-Reply-To: <1002835182.1604.13.camel@ogre>
Message-ID: <Pine.LNX.4.33.0110121203220.7418-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Oct 2001, John J Tobin wrote:

> On Thu, 2001-10-11 at 14:14, bill davidsen wrote:
> > In article <1002667385.1673.129.camel@phantasy> rml@tech9.net wrote:
> >
> > >Completely Agreed.  I am thinking of getting a dual AMD system for doing
> > >more kernel work (tackle AMD and SMP).  My main machine is a P3 now.
> >
> > The issue right now may be RAM cost. I just bought 512MB PC133 for
> > $140/GB, while "registered PC2100" memory is about $900 from the same
> > source. I think that's what the Tiger wants, isn't it?

registered ecc dimms from crucial and kingston valueram are barely more
than non-registered parts... I see the 512MB kingston registered ecc ddram
part for $220 from a large mailorder house. the same spec part from
corsair is still $489 from the same vendor. given the headaches that
result from having to debug problems/faulty dimms on a machine with 2GB of
ram and the non-trivial engineering that went into getting 4 reasonably
spaced ddr dimm sockets on the mainboard. I expect registered ecc dimms
will be well worth it, if only so that you can rule out the memory as the
culprit if you have certain kinds of issues...

joelja


> > --
> > bill davidsen <davidsen@tmr.com>
>
> The Tyan Tiger and Thunder both take Registered DDR DIMMs. Though
> anandtech got it running using only one pair of unregistered, other
> combinations of unregistered failed to boot. There are also no SMP
> athlon chipsets that use PC133.
>
>
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


