Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132178AbRAVQQK>; Mon, 22 Jan 2001 11:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRAVQQA>; Mon, 22 Jan 2001 11:16:00 -0500
Received: from kyle.comstar.net ([207.15.208.108]:12044 "HELO kyle.comstar.net")
	by vger.kernel.org with SMTP id <S132178AbRAVQPv>;
	Mon, 22 Jan 2001 11:15:51 -0500
Date: Mon, 22 Jan 2001 11:15:45 -0500 (EST)
From: Gregory McLean <gregm@comstar.net>
To: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
cc: Jeff Hartmann <jhartmann@valinux.com>,
        "Justin T. Gibbs" <gibbs@scsiguy.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        John Mifsud <john.mifsud@au.interpath.net>,
        Armin Obersteiner <armin@xos.net>
Subject: Re: Patch for aic7xxx 2.4.0 test12 hang
In-Reply-To: <3A6BC565.2EE6E268@mailhost.cs.rose-hulman.edu>
Message-ID: <Pine.LNX.4.10.10101221109390.22715-100000@coco.comstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2001, Leslie Donaldson wrote:

> Jeff Hartmann wrote:
> > 
> > >> There is also a known issue with U160 modes and the currently
> > >> embedded aic7xxx driver.
> > >
> > >
> > > That's true the problem is the TCQ command seems to be sequencing wrong.
> > >
> > >
> > >> You might want to try the Adaptec
> > >> supported driver from here:
> > >>
> > >> http://people.FreeBSD.org/~gibbs/linux/
> > >>
> > >> 6.09 BETA should be released later today.

I'll give the 6.09 driver a try 6.08 locks up on me after some time.


Gregory McLean     | "Why do they call it a TV set when you only get one?"
globix.net         | - George Carlin 
Core Engineer      |
Network Services   |
PGP Key: 0xE94D1363|
---------------This is my opinion, All MINE! I tell you-----------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
