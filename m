Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275295AbRIZQUS>; Wed, 26 Sep 2001 12:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275294AbRIZQUJ>; Wed, 26 Sep 2001 12:20:09 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:27140 "EHLO
	master.aslab.com") by vger.kernel.org with ESMTP id <S273668AbRIZQT6>;
	Wed, 26 Sep 2001 12:19:58 -0400
Date: Wed, 26 Sep 2001 09:04:33 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Arjan van de Ven <arjanv@redhat.com>
Subject: Re: BSD-Linux FlameWar over SoftRAID.
In-Reply-To: <E15mHJc-0000kH-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0109260900550.5107-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

The real problem is that the header content is incomplete and wrong for
complete feature usage.  I will write a signature header file for the
various flavors and document the ownership of the IP and the terms of
usage.

This should be an optimal solution.

I gather you are point to me as the 1% for the Linux KOOKs ;-)

Cheers,

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                    Tel: (510) 857-0055 x103
38875 Cherry Street                          Fax: (510) 857-0010
Newark, CA 94560                             Web: www.aslab.com

On Wed, 26 Sep 2001, Alan Cox wrote:

> > It is clear that BSD is going off the deep end.
>
> Andre - 99% of the BSD developers are sane reasonable people. They have
> their kooks we have ours. Since both headers appear to be representations
> of a third party datastructure the matter is also completely irrelevant.
> I would suggest folks read up a little on copyright law with regard to
> interfaces and definitions.
>
> Now if Arjan did copy the stuff by reference to the BSD drivers, then no
> he didn't do anything wrong - but I agree it would have been polite to have
> duly credited it. It would also have been polite if the BSD person concerned
> had contacted him privately and asked too
>
> Alan
>

