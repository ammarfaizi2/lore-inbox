Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317234AbSEXSbV>; Fri, 24 May 2002 14:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317235AbSEXSbU>; Fri, 24 May 2002 14:31:20 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:58292 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317234AbSEXSbT>; Fri, 24 May 2002 14:31:19 -0400
Date: Fri, 24 May 2002 20:30:57 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, tori@ringstrom.mine.nu,
        imipak@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Linux crypto?
In-Reply-To: <E17BK0J-00073M-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.05.10205242028060.11037-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, Alan Cox wrote:

> > > They won't let me (or any other US citizen) make any edits to any of
> > > the ipsec sources if it were to be added to the main tree.  That's
> > > unacceptable because it means that effectively I cannot maintain the
> > > networking.
> > 
> > well the _big_ thing the freeswan people are afraid of, is exactly the
> > crypto laws in the us.
> 
> They refuse to have a US citizen working on it. Which is reasonable given
> the historu of US law, but until the US finishes outlawing computers in 
> a couple of years that is a problem.

well probably everything which isn't plain english written with a pen
on white paper would be outlawed by then ;)
... but what about having all the crypto stuff in question beeing handled
by modules (developed outside the USSA) and having the networking-related
code in the kernel - could the hooks itself be a problem?

	tm
-- 
in some way i do, and in some way i don't.

