Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSIOBEL>; Sat, 14 Sep 2002 21:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSIOBEK>; Sat, 14 Sep 2002 21:04:10 -0400
Received: from mail.rpi.edu ([128.113.22.40]:18396 "EHLO mail.rpi.edu")
	by vger.kernel.org with ESMTP id <S317637AbSIOBEK>;
	Sat, 14 Sep 2002 21:04:10 -0400
Date: Sat, 14 Sep 2002 21:08:38 -0400 (EDT)
From: Hua Qin <qinhua@poisson.ecse.rpi.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux client specweb test  hung
In-Reply-To: <1032010021.12892.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.10.10209142106390.12355-100000@poisson.ecse.rpi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Sep 2002, Alan Cox wrote:

> On Sat, 2002-09-14 at 14:08, Hua Qin wrote:
> > 
> > Hi,
> > 
> > I think someone already have this discussion about this hung, but I did
> > not see some solutions about. Here is my test case:
> > 
> > 1 Zeus web server: kernel 2.4.7-10
> > 7 Specweb clients: kernel 2.2.16
> 
> 2.4.17 is an old kernel with multiple errata fixes.
> 2.2.16 is obsolete, with known later networking, driver and other bugs
> fixed.
> 
> Start with something current and see if you can duplicate the problem.
> 
> 
So do you think 2.4.7-10 or 2.4.17 has multiple errata fixes. or both :)
Thanks!
Hua

