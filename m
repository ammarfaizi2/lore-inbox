Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263851AbRFRJPp>; Mon, 18 Jun 2001 05:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263874AbRFRJPf>; Mon, 18 Jun 2001 05:15:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:36882 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S263851AbRFRJPS>;
	Mon, 18 Jun 2001 05:15:18 -0400
Date: Mon, 18 Jun 2001 11:14:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Alexander Viro <viro@math.psu.edu>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Flynn <Dave@keston.u-net.com>, <rjd@xyzzy.clara.co.uk>,
        Bill Pringlemeir <bpringle@sympatico.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Newbie idiotic questions.
In-Reply-To: <Pine.GSO.4.21.0106171821430.15952-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0106181111210.6596-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Jun 2001, Alexander Viro wrote:

> > typeof?  It's rather popular in the kernel already.  Besides, who is going to
>
> Really? 5 instances in PPC arch-specific code, 1 (absolutely gratitious)
> in drivers/mtd, 2 - in m68k (also useless), 4 - in drivers/video, 2 -
> in AFFS and 1 - in netfilter.
>
> I wouldn't call it "rather popular".

You should also grep for '__typeof__'. :-)

bye, Roman

