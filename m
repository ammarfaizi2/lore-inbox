Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbQLNFUH>; Thu, 14 Dec 2000 00:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132466AbQLNFT5>; Thu, 14 Dec 2000 00:19:57 -0500
Received: from www.wen-online.de ([212.223.88.39]:56592 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129826AbQLNFTr>;
	Thu, 14 Dec 2000 00:19:47 -0500
Date: Thu, 14 Dec 2000 05:49:16 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 randomly hangs up
In-Reply-To: <200012132247.eBDMlM201139@lt.wsisiz.edu.pl>
Message-ID: <Pine.Linu.4.10.10012140541560.1063-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Lukasz Trabinski wrote:

> In article <20001213121349.A6787@sarah.kolej.mff.cuni.cz> you wrote:
> 
> > I can (re)confirm that. I work several hours on console without any
> > problem ... then I start X session and after several minutes system
> > hangs.
> 
> I can confirm that, too.
> Todaye, crashed two difference machines
> One: AMD-K6 3D, 300 MHz, RH 7.0 + updates, 64MB RAM
> Second one: AMD Athlon 600, 600MHz with, 128MB RAM, RH 7.0+updates
> 
> > Red Hat 7.0, XFree-3.3.6 (SVGA server), S3Virge/G2 (4MB)
> 
> > (no problems with -test11 and 2.2.x before ...)
> 
> Exactly

Not here.  I've been seeing occasional hard freezes since test10.
Mostly after a period of idle cpu (reading kernel code.. reader
enters catatonic state with smoke pouring out ears;) X isn't running.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
