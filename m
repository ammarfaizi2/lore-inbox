Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSGLPfH>; Fri, 12 Jul 2002 11:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSGLPfG>; Fri, 12 Jul 2002 11:35:06 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30730
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316587AbSGLPfF>; Fri, 12 Jul 2002 11:35:05 -0400
Date: Fri, 12 Jul 2002 08:34:57 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <20020712130702.GL29993@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.10.10207120826580.20499-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.linuxdiskcert.org/LAD-ide24-2.5.25.patch.bz2

This is currently x86 limited and soon will be recored to the modern api
that is so desired.  It will also maintion 100% backwards compatablity.
It will tested and run in various environments and combinations.

Lastly all of you can trust that I will not destroy your data because of
an October deadline.

For all of you out there complaining I write crap code, well if you saw
the download list of the web logs, without this announcement that in
itself would make the following statement.

Bring back the old and lousy, the new and improved is only a shiny sticker.

Since I really have had little success in submission of patches for 2.4,
I can play with 2.5.  The best part is I can glean from the mess that is
good, and make a final solution which shall work.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Fri, 12 Jul 2002, Tomas Szepe wrote:

> > > In favour of the scrap:
> > > 
> > > 1. HPA.
> > > 2. Adam J. Richter.
> > > 3. Marcin Dalecki (basically due to give up on the idea
> > > of gradual unification).
> > 
> > In other words nobody who understands IDE is for and everyone who 
> > understands you can't actually get rid of ide-floppy, tape, cdrom internal
> > support and knows about IDE is..
> > 
> > > Against:
> > > 1. Bart=B3omiej =AFo=B3nierkiewcz.
> > > 
> > 
> > against..
> 
> 
> Very well put.
> 
> By the way, where's the promised IDE 98?
> 
> 
> T.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

