Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbRAUSee>; Sun, 21 Jan 2001 13:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132104AbRAUSeZ>; Sun, 21 Jan 2001 13:34:25 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37638 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131579AbRAUSeI>;
	Sun, 21 Jan 2001 13:34:08 -0500
Message-ID: <3A6B2B86.5A0C760@mandrakesoft.com>
Date: Sun, 21 Jan 2001 13:33:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: idalton@ferret.phonewave.net
CC: egger@suse.de, burnus@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Ethernet drivers: SiS 900, Netgear FA311
In-Reply-To: <3A6A2D8D.D55655D5@mandrakesoft.com> <20010121134822.A46D4735B@Nicole.muc.suse.de> <20010121102315.A16586@ferret.phonewave.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

idalton@ferret.phonewave.net wrote:
> 
> On Sun, Jan 21, 2001 at 01:54:34PM +0100, egger@suse.de wrote:
> > On 20 Jan, Jeff Garzik wrote:
> >
> > > Not true, see natsemi.c (in 2.4.x at least).
> >
> >  Correct, and the cards really work with it.
> 
> natsemi did not work with 2.2.17 on a remote system I do work on, but
> did work with the 2.4.0-included driver. Wonder if it'll be making it
> into 2.2.x soon..

It is available for 2.2 from http://www.scyld.com/network/ ...  All I
did was port the Becker driver to 2.4.

If someone wants to port his driver into 2.2.latest, I'm sure people
will be happy..

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
