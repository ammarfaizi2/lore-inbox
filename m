Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265891AbRF2PXF>; Fri, 29 Jun 2001 11:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265997AbRF2PWz>; Fri, 29 Jun 2001 11:22:55 -0400
Received: from [192.48.153.1] ([192.48.153.1]:51818 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S265922AbRF2PWt>;
	Fri, 29 Jun 2001 11:22:49 -0400
Message-Id: <200106291523.f5TFNhC32686@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Dan Kegel <dank@kegel.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT please; Sybase 12.5 
In-Reply-To: Message from Dan Kegel <dank@kegel.com> 
   of "Fri, 29 Jun 2001 02:39:00 PDT." <3B3C4CB4.6B3D2B2F@kegel.com> 
Date: Fri, 29 Jun 2001 10:23:43 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


XFS supports O_DIRECT on linux, has done for a while.

Steve

> At work I had to sit through a meeting where I heard
> the boss say "If Linux makes Sybase go through the page cache on
> reads, maybe we'll just have to switch to Solaris.  That's
> a serious performance problem."
> All I could say was "I expect Linux will support O_DIRECT
> soon, and Sybase will support that within a year."  
> 
> Er, so did I promise too much?  Andrea mentioned O_DIRECT recently
> ( http://marc.theaimsgroup.com/?l=linux-kernel&m=99253913516599&w=2,
>  http://lwn.net/2001/0510/bigpage.php3 )
> Is it supported yet in 2.4, or is this a 2.5 thing?
> 
> And what are the chances Sybase will support that flag any time
> soon?  I just read on news://forums.sybase.com/sybase.public.ase.linux
> that Sybase ASE 12.5 was released today, and a 60 day eval is downloadable
> for NT and Linux.  I'm downloading now; it's a biggie.
> 
> It supports raw partitions, which is good; that might satisfy my
> boss (although the administration will be a pain, and I'm not
> sure whether it's really supported by Dell RAID devices).
> I'd prefer O_DIRECT :-(
> 
> Hope somebody can give me encouraging news.
> 
> Thanks,
> Dan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


