Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316433AbSEWSq1>; Thu, 23 May 2002 14:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316982AbSEWSq0>; Thu, 23 May 2002 14:46:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18187
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316433AbSEWSqZ>; Thu, 23 May 2002 14:46:25 -0400
Date: Thu, 23 May 2002 11:44:44 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: "Gryaznova E." <grev@namesys.botik.ru>, linux-kernel@vger.kernel.org
Subject: Re: IDE problem: linux-2.5.17
In-Reply-To: <20020523180357.GA725@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.10.10205231143390.22581-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not true at all.

Many of the OEM's use 40c's to do 66 and 100, just they have to be very
high quality and about 6" in length.

On Thu, 23 May 2002, Tomas Szepe wrote:

> > I have 40 wires cable. When ide=nodma is passed to 2.5.17 kernel -
> > kernel boots. Am I correct that it is not possible to have DMA
> > on with such cable? Is there any reason for doing that?
> 
> 40-conductor IDE cables are capable of transfering data
> in DMA modes up to udma2, but no faster.
> 
> T.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

