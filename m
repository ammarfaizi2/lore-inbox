Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSIAHBB>; Sun, 1 Sep 2002 03:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSIAHBB>; Sun, 1 Sep 2002 03:01:01 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:27909
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316339AbSIAHBA>; Sun, 1 Sep 2002 03:01:00 -0400
Date: Sun, 1 Sep 2002 00:05:07 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Peter <cogweb@cogweb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.xx IDE development policy
In-Reply-To: <Pine.LNX.4.44.0208312204080.13065-100000@greenie.frogspace.net>
Message-ID: <Pine.LNX.4.10.10209010002250.4104-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Peter,

The water is warm, get wet!

As far as Promise, I am working on a contract w/ their development group
to solve all of these issues for good.

I find it interesting that 2.4.16 is rock solid.

Since I am still picking up the pieces and sorting out patch trees, if you
have a copy of that patch and would send it back my way. It will go a long
way to solving the mystery.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Sat, 31 Aug 2002, Peter wrote:

> 
> I'm confident that the development of IDE drivers for 2.4 is in excellent
> hands, with Alan and Andre working together. Still, the IDE drivers on the
> popular Promise cards have been unstable for a while now, and things have 
> clearly gone from quite good to worse.
> 
> Andre appears to be faced with very buggy and idiosyncratic hardware, and
> the recent problems have been introduced in the attempt to accomodate for
> this. Personally, for instance, I'm still running 2.4.16 with Andre's
> patch on a Promise '69 and a 160GB drive, and I've never had a hint of a
> problem -- heavy use over networks for months. Now people are reporting
> serious problems with this card.
> 
> Non-functioning harddrives is obviously not as bad as losing data, but
> still this is a bummer, man. How about a development policy to consolidate
> progress and reduce the complexity of the task? Something like, Promise
> cards that operate to spec get left alone. Idiosyncratic cards get an
> experimental label and warnings, maybe only unofficial support through
> patches, or they get marked as bad.
> 
> Add a diagnostic to the documentation. Let people bug the vendor about out 
> of spec hardware. 
> 
> Linus commented earlier on how ATA development drives people up the wall; 
> we just had one person burn out. So let's do something about it. 
> 
> Cheers,
> Peter
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

