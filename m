Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSEANLm>; Wed, 1 May 2002 09:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSEANLl>; Wed, 1 May 2002 09:11:41 -0400
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:63117 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312169AbSEANLk>; Wed, 1 May 2002 09:11:40 -0400
Date: Wed, 1 May 2002 14:11:33 +0100 (BST)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@gerber
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in "page_alloc.c" with 2.4.19-pre7-ac2
In-Reply-To: <3CCFE83F.B858A101@redhat.com>
Message-ID: <Pine.GSO.4.44.0205011409070.1714-100000@gerber>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Basically, "page_alloc.c" generated a BUG error when unmounting my
> > filesystems during a reboot. I wasn't able to capture the full output,
> > but I hope may be useful to report this anyway. If it happens again I'll
> > try to grab the details....
>
> Are you using the nvidia driver by chance ?

Umm, yes, as it happens. Forgive my non-kernel hacking ignorance, but I
didn't draw an obvious connection between these things! If it's
somehow the fault of the nVidia driver, then I know enough not to
complain to l-k :-)

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

