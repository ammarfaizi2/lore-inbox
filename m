Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313562AbSDUQpW>; Sun, 21 Apr 2002 12:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313564AbSDUQpV>; Sun, 21 Apr 2002 12:45:21 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43154 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313562AbSDUQpU>; Sun, 21 Apr 2002 12:45:20 -0400
Date: Sun, 21 Apr 2002 10:45:18 -0600
Message-Id: <200204211645.g3LGjIr20144@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <E16yxqh-0000k6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On Sunday 21 April 2002 18:27, Richard Gooch wrote:
> > Daniel Phillips writes:
> > > On Saturday 20 April 2002 18:13, Anton Altaparmakov wrote:
> > > > Daniel,
> > > > 
> > > > This is not documentation for bitkeeper but how to use bitkeeper 
> > > > effectively for kernel development. It happens to be DAMN USEFULL 
> > > > documentation at that for anyone wanting to use bitkeeper for kernel 
> > > > development so IMO it fully belongs in the kernel. Just like the 
> > > > SubmittingPatches document does, too. Or are you going to remove that as well?
> > > 
> > > By that logic, we should also include the lkml FAQ in the kernel
> > > tree.  Should we?
> > 
> > No. A pointer to the lkml FAQ is sufficient.
> 
> Was that a hint?

Not really. I'm just answering your question about whether the lkml
FAQ should be distributed with the kernel sources. As far as I know,
there is a pointer, but I haven't looked. If there isn't feel free to
send Linus and Marcelo a patch.

> Then certainly, a pointer to the BK documentation would be
> sufficient, and save download bandwidth as well.

I wasn't talking about that. And I won't O:-) But I wonder if I added
something to the lkml FAQ whether we might avoid some rounds of this
repeat flamewar?

Nah.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
