Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319007AbSHWSNH>; Fri, 23 Aug 2002 14:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319035AbSHWSNH>; Fri, 23 Aug 2002 14:13:07 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:27657
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319007AbSHWSNG>; Fri, 23 Aug 2002 14:13:06 -0400
Date: Fri, 23 Aug 2002 11:16:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Markus Plail <plail@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
In-Reply-To: <87d6s9a7pa.fsf@plailis.homelinux.net>
Message-ID: <Pine.LNX.4.10.10208231116000.14761-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have the problem fixed but I want to verify twice.


On Fri, 23 Aug 2002, Markus Plail wrote:

> Hi Alan!
> 
> * Alan Cox writes:
> >The HP merge is now down to 3503 lines pending
> >IDE status
> >	Chasing two reports of strange ide-scsi crashes
> 
> As the problem still exists with this version, I fiddled a bit with
> different kernel option. I realized that the problem only occurs, when
> I have DMA enabled. As soon as I disable it, I can mount CD-ROM/DVDs
> without the formerly reported kernel oops.
> 
> Hope it helps
> regards
> Markus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

