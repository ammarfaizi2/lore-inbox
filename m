Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277230AbRJHWWf>; Mon, 8 Oct 2001 18:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277340AbRJHWW2>; Mon, 8 Oct 2001 18:22:28 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:45994 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S277230AbRJHWWU>; Mon, 8 Oct 2001 18:22:20 -0400
Date: Mon, 8 Oct 2001 15:25:15 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: <kernel@ddx.a2000.nu>
cc: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
        <sparclinux@vger.kernel.org>
Subject: Re: sun + gigabit nic
In-Reply-To: <Pine.LNX.4.40.0110090001300.28619-100000@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.33.0110081518370.17654-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001 kernel@ddx.a2000.nu wrote:

>
> On 8 Oct 2001, Thomas Duffy wrote:
>
> > On Sat, 2001-10-06 at 09:44, kernel@ddx.a2000.nu wrote:
> >
> > > so will the netgear gigabit adapter work with the ultrasparc linux kernel
> > > ?
> > > (the netgear ga622t ?)

the 620t is the netgear gig-card based on the acenic, it' optical, sx or
lx.

> > this is netgear's gige over copper card. it does not use the acenic
> > chip.  instead it uses the national semiconductor 83820 chip and a
> > different driver. this driver did not go into the kernel until ~2.4.10
> > (ns83820.c) and does not work under sparc64 so far -- it seems to
>
> so any gigabit copper cards that DO work under sparc64 ?
> i looked at the intel source (on support.intel.com)
> but it gives me some errors when i try to compile it on sparc
>
> what about the 3Com 3C996-T ? (which has also drivers for linux on the
> support page)
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


