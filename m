Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280028AbRKRSxT>; Sun, 18 Nov 2001 13:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280029AbRKRSxK>; Sun, 18 Nov 2001 13:53:10 -0500
Received: from mx3out.umbc.edu ([130.85.253.53]:5313 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S280028AbRKRSw7>;
	Sun, 18 Nov 2001 13:52:59 -0500
Date: Sun, 18 Nov 2001 13:52:56 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
cc: John Jasen <jjasen@realityfailure.org>, <linux-kernel@vger.kernel.org>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <Pine.SGI.4.31L.02.0111181333410.12354143-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.SGI.4.31L.02.0111181351370.12354143-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, John Jasen wrote:

> > As far as I can see the 2.4.X kernel gives much better throughput,
> > but 4-5 hours for compiling the kernel is way too long on a 700Mhz
> > celeron. Please try to do a
> > $ make dep clean && time make bzImage -j 3
> > on both 2.2.19 and 2.4.X kernel and send the time information.


// RH 2.2.19-6.2.1
439.35user 54.86system 8:19.45elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (357039major+484758minor)pagefaults 0swaps

// 2.4.12
(still in make dep) ...

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

