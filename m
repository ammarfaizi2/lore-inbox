Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbRHaUhx>; Fri, 31 Aug 2001 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269254AbRHaUho>; Fri, 31 Aug 2001 16:37:44 -0400
Received: from anime.net ([63.172.78.150]:45833 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S269229AbRHaUhh>;
	Fri, 31 Aug 2001 16:37:37 -0400
Date: Fri, 31 Aug 2001 13:37:16 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        David Hollister <david@digitalaudioresources.org>,
        Jan Niehusmann <jan@gondor.com>, <linux-kernel@vger.kernel.org>,
        <rgooch@atnf.csiro.au>
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <E15coqr-0003DR-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0108311335150.9298-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001, Alan Cox wrote:
> > So what happens when someone is able to duplicate the problem on say AMD
> > 760MP chipset with registered ECC PC2100 ram and 450W power supply?
> > Not to say it has happened yet (I havent got my dual Tyan Tiger MP yet :-)
> > but where would the finger start pointing then?
> That would make it a lot more complex. There were a few cases much earlier
> on with AMD chipset lockups but those have been cured (and were an Athlon
> processor errata where a prefetch of an uncacheable line made a very very
> nasty mess).

Can you define a hardware configuration that if it fails under athlon
optimizations, you would consider a falsification of the "marginal
hardware" theory?

I want a hardware config that will get everyones attention if it fails.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

