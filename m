Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbRAaVLZ>; Wed, 31 Jan 2001 16:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbRAaVLP>; Wed, 31 Jan 2001 16:11:15 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:34577
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129911AbRAaVLK>; Wed, 31 Jan 2001 16:11:10 -0500
Date: Wed, 31 Jan 2001 13:10:38 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Dan Hollis <goemon@anime.net>
cc: Mark Lord <mlord@pobox.com>,
        Rupa Schomaker <rupa-list+linux-kernel@rupa.com>,
        Andries.Brouwer@cwi.nl, ole@linpro.no, linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <Pine.LNX.4.30.0101311254350.19040-100000@anime.net>
Message-ID: <Pine.LNX.4.10.10101311310300.13759-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay......

On Wed, 31 Jan 2001, Dan Hollis wrote:

> On Wed, 31 Jan 2001, Andre Hedrick wrote:
> > On Wed, 31 Jan 2001, Mark Lord wrote:
> > > Even better would be to add a stage in front of the fall-back,
> > > which queries the BIOS (from kernel startup code) for translation
> > > info on ALL drives.
> > Maybe a compile option could help...
> 
> kernel parameter passed via lilo...
> 
> -Dan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
