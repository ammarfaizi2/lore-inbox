Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272559AbRIFUch>; Thu, 6 Sep 2001 16:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272558AbRIFUc1>; Thu, 6 Sep 2001 16:32:27 -0400
Received: from anime.net ([63.172.78.150]:28934 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S272559AbRIFUcR>;
	Thu, 6 Sep 2001 16:32:17 -0400
Date: Thu, 6 Sep 2001 13:32:16 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <tegeran@home.com>, <linux-kernel@vger.kernel.org>
Subject: Re: K7/Athlon optimizations and Sacrifices to the Great Ones.
In-Reply-To: <E15f5e7-0000PU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0109061330420.8699-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Alan Cox wrote:
> > At this point, I'd like to sacrifice a Red Hat Linux 6.2 CD to Alan Cox.
> > I would also like to sacrifice Minix 1.3(?) installation diskettes to
> > Linus Torvalds.
> > I perform these sacrifices in the hope that enlightenment comes to me.
> A deep booming voice says "I have no idea either"

We need a good tester (floppy-bootable k7-killer, something along the
lines of memtest86) and many more data points.

Anyone yet verified if burnMMX2 causes the same failures the
athlon-optimized kernel does?

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

