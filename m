Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311924AbSCODmA>; Thu, 14 Mar 2002 22:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311925AbSCODlu>; Thu, 14 Mar 2002 22:41:50 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:35812 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S311924AbSCODlj>;
	Thu, 14 Mar 2002 22:41:39 -0500
Date: Thu, 14 Mar 2002 19:41:37 -0800
To: David Gibson <david@gibson.dropbear.id.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, jt@hpl.hp.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
Message-ID: <20020314194137.A15075@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020313185915.A14095@bougret.hpl.hp.com> <E16lLnM-0008E8-00@the-village.bc.nu> <20020313191159.B14095@bougret.hpl.hp.com> <3C9015D2.4060108@mandrakesoft.com> <20020315024300.GC1289@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020315024300.GC1289@zax>; from david@gibson.dropbear.id.au on Fri, Mar 15, 2002 at 01:43:00PM +1100
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 01:43:00PM +1100, David Gibson wrote:
> 
> Yes, I'll try to send some in.  When 2.5 had just started I figured
> Linus was busy enough with the bio stuff and the driver updates could
> wait, since then I've been busy with other things so I haven't gotten
> around to sending patches.
> 
> AFAIK none of the APIs which are relevant to me have changed so it
> should just be a matter of copying the files across from 2.4.

	Hu ho... You are reading LKML. I'd better be careful about
what I'm saying ;-)
	By the way, you are right, I've been using 9b in 2.5.6 without
any trouble. But, it seem that my patch will get in 2.4.X, so you will
have it both way.

	By the way, what's the situation regarding our famous ALLOC
irq handling ? Any improvement ? I haven't tried v10, so I just wonder
if it's worth upgrading ;-)

	Have fun...

	Jean
