Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318503AbSH1BNd>; Tue, 27 Aug 2002 21:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSH1BNc>; Tue, 27 Aug 2002 21:13:32 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24077
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318503AbSH1BNc>; Tue, 27 Aug 2002 21:13:32 -0400
Date: Tue, 27 Aug 2002 18:15:57 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: rwhron@earthlink.net
cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
In-Reply-To: <20020828004304.GA16704@rushmore>
Message-ID: <Pine.LNX.4.10.10208271814490.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, that has been verified and there are more extentions needed to bring
up support for all archs.  I will send them to Al and Alan first and post
them here too shortly I hope.

Cheers,

On Tue, 27 Aug 2002 rwhron@earthlink.net wrote:

> > IDE merge is b0rken wrt partitioning.  Patchset that is supposed to fix
> > that stuff is on ftp.math.psu.edu/pub/viro/IDE/* 
> 
> I was getting this on 2.5.32:
> mount: wrong fs type, bad option, bad superblock on /dev/hda1,
>        or too many mounted file systems
> 
> With Al's patchset, 2.5.32 is mounting my IDE filesystems okay.
> 
> -- 
> Randy Hron
> http://home.earthlink.net/~rwhron/kernel/bigbox.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

