Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKUJhR>; Tue, 21 Nov 2000 04:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKUJhH>; Tue, 21 Nov 2000 04:37:07 -0500
Received: from hermes.mixx.net ([212.84.196.2]:65032 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129091AbQKUJg6>;
	Tue, 21 Nov 2000 04:36:58 -0500
From: Harald Wagener <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Harald Wagener <wagener@innominate.com>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: Abit VP6 HPT370 support?
Date: 21 Nov 2000 10:06:46 +0100
Organization: innominate AG
Distribution: local
Message-ID: <news2mail-xadofz9d789.fsf@innominate.com>
In-Reply-To: <Pine.LNX.4.21.0011201227001.3379-100000@sliver.moot.mb.ca> <Pine.LNX.4.21.0011201930120.2645-100000@neo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: mate.bln.innominate.de 974797617 8499 10.0.64.200 (21 Nov 2000 09:06:57 GMT)
X-Complaints-To: news@innominate.de
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de writes:

> On Mon, 20 Nov 2000, Michael J. Dikkema wrote:
> 
> > Does Linux 2.4pre support the raid controller on the abit vp6? The kernel
> > says it supports the 370, but it doesn't mention raid. I was confused as
> > to if there was a difference or not.
> 
> I have a standalone card with the HPT370 chipset doing RAID fine.
> Or at least did until one of the drives died within an hour of using it.
> This was drive failure, not the card though. Whilst it was working,
> it seemed to be working fine. :)
> 
> > Also, OT, does anyone know if the controller is managed through hardware
> > or through software?
> 
> The packaging / manual for this card suggests that its hardware based.
> If it isn't, it's extremely misleading.

There is an article about it in the current c't magazine which states
the RAID is done by the board's BIOS, but is not better than software
raid. I  don't have the magazine at hand, so I can't go into detail. 

H.

-- 
harald.wagener@innominate.com
system engineer                                         innominate AG
                                                 the linux architects       
tel: +49.30.308806-0  fax: -77              http://www.innominate.com 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
