Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbRAaNHF>; Wed, 31 Jan 2001 08:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130575AbRAaNGz>; Wed, 31 Jan 2001 08:06:55 -0500
Received: from mdmgrp1-235.accesstoledo.net ([207.43.106.235]:13316 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129777AbRAaNGk>;
	Wed, 31 Jan 2001 08:06:40 -0500
Date: Mon, 29 Jan 2001 21:19:18 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: Alex Belits <abelits@phobos.illtel.denver.co.us>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPP broken in Kernel 2.4.1?
In-Reply-To: <Pine.LNX.4.20.0101310453400.18462-100000@phobos.illtel.denver.co.us>
Message-ID: <Pine.LNX.4.21.0101292117590.460-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Alex Belits wrote:
>
> On Mon, 29 Jan 2001, Michael B. Trausch wrote:
> 
> > I'm having a weird problem with 2.4.1, and I am *not* having this problem
> > with 2.4.0.  When I attempt to connect to the Internet using Kernel 2.4.1,
> > I get errors about PPP something-or-another, invalid argument.  I've tried
> 
>   Upgrade ppp to 2.4.0b1 or later -- it's documented in 
> Documentation/Changes.
> 

Okay.  Must have overlooked that, I've got 2.4.0.  *happily goes and gets
the new pppd*  :-P

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
