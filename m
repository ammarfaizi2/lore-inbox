Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263387AbSJFMBr>; Sun, 6 Oct 2002 08:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263388AbSJFMBr>; Sun, 6 Oct 2002 08:01:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14524 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S263387AbSJFMBq>;
	Sun, 6 Oct 2002 08:01:46 -0400
Date: Sun, 6 Oct 2002 14:18:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Ulrich Drepper <drepper@redhat.com>, <bcollins@debian.org>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: BK MetaData License Problem?
In-Reply-To: <20021006.045201.26534685.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210061410540.5162-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Oct 2002, David S. Miller wrote:

> Anything you write is automatically copyrighted by you, even if you
> don't specifically state it as such.
>
> That is my basic understanding of copyright law.
> 
> BitMover et al. can't take your copyright powers away from you.

yes, this is my understanding as well, but the BK license can require you
to license your bits in exchange for allowing you to use the BK product.  
It already does require 'republishing rights' for the metadata bits in
fact. (which is a perfectly fair requirement - Larry needs this assurance
to be able to host bkbits in a legally safe way.)

the issue is that in the BK repository data and metadata is distinctly
separate. The Linux kernel is fully functional without any of the
metadata, and the GPL only covers the Linux kernel.

And i'd like note it that this situation is not "BK's fault" in any way,
it's simply the thing that copyright law says about not explicitly
licensed bits. But it's a situation created by BK, and it could be
eliminated by the BK license requiring the metadata to be licensed under
the same conditions the data itself is licensed. Or we could put this into
the Linux kernel license. (which OTOH might violate the GPL.)

i'm sure this issue was raised before - eg. what is the legal standing of
the commit messages of the BSD kernels?

	Ingo

