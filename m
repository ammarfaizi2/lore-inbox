Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTANVRN>; Tue, 14 Jan 2003 16:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTANVRN>; Tue, 14 Jan 2003 16:17:13 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:3079 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265285AbTANVRL>; Tue, 14 Jan 2003 16:17:11 -0500
Date: Tue, 14 Jan 2003 13:23:21 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rakesh Sachdeva <raksac@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Sata on Intel D845PEBT2 motherboard
In-Reply-To: <F49lB4BwOZxYS0qPzg900000371@hotmail.com>
Message-ID: <Pine.LNX.4.10.10301141322010.23438-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is only ONE.

If you can not apply the patches, you have other things patched over.
This is not anyones problem, if you want it solved try offline.

Cheers,

On Tue, 14 Jan 2003, Rakesh Sachdeva wrote:

> Hello SATA experts,
> 
> I need your help with pointers on the Silicon Image SATA controller on the 
> Intel D845PEBT2 motherboard. Intel provides only windowz driver for it and 
> refuses to do anything with Linux. I would appreciate if you could help me 
> with locating a patch for the mainline linux kernel tree of 2.4.19 or 
> 2.4.20.
> 
> I have looked at SATA for SiI release location http://www.linux-ide.org for 
> the same using it against a patched kernel version. But for some reasons I 
> have been struggling to use them. Most of the time I get compilation 
> problems since the ac patch moves a lot of dependencies *.h files into 
> *.h.orig files which causes the build to break.
> 
> I would highly appreciate any pointers in helping me overcome this problem.
> 
> Thanks in advance,
> Rakesh
> 
> 
> 
> 
> "Happy people don't necessarily have the best of
> everything. They make the best of everything!"
> -------------------------------
> No Matter Who You Are, Most Of The Smartest People Work For Someone Else 
> (Bill Joy).
> 
> 
> 
> 
> 
> _________________________________________________________________
> MSN 8 helps eliminate e-mail viruses. Get 2 months FREE* 
> http://join.msn.com/?page=features/virus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

