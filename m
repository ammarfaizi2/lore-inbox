Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSHLJHy>; Mon, 12 Aug 2002 05:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317599AbSHLJHy>; Mon, 12 Aug 2002 05:07:54 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18188
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317610AbSHLJHx>; Mon, 12 Aug 2002 05:07:53 -0400
Date: Mon, 12 Aug 2002 02:02:53 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Nokleberg <chris@sixlegs.com>, linux-kernel@vger.kernel.org
Subject: Re: [chris@sixlegs.com: PROBLEM: Unable to read superblock in 2.4.19]
In-Reply-To: <1029146988.16236.115.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10208120201280.3940-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

I already answered the original message to "bugs@linux-ide.org".

It is the lovely indexing of HBA's :-/

ide=reverse

This should get him back online for debugging the rest.

Cheers,

On 12 Aug 2002, Alan Cox wrote:

> On Mon, 2002-08-12 at 07:57, Chris Nokleberg wrote:
> > I sent this to bugs@linux-ide.org a few days ago but I'm not sure if
> > that goes anywhere.
> 
> I need a longer version of the console data to see what the problem may
> be. 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

