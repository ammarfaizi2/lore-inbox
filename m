Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280083AbRKITjt>; Fri, 9 Nov 2001 14:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280082AbRKITjc>; Fri, 9 Nov 2001 14:39:32 -0500
Received: from anime.net ([63.172.78.150]:65286 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S280061AbRKITjQ>;
	Fri, 9 Nov 2001 14:39:16 -0500
Date: Fri, 9 Nov 2001 11:38:54 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Xavier Bestel <xavier.bestel@free.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: Lockup in IDE code
In-Reply-To: <200111091656.fA9GusD06947@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.30.0111091138140.30935-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Richard Gooch wrote:
> GXavier Bestel writes:
> > le ven 09-11-2001 à 03:17, Richard Gooch a écrit :
> > >   Hi, all. I tried to use my IDE CD-ROM today, the first time in a
> > > long while. When attempting to mount it, the machine locked up,
> > > hard. Even SysReq didn't work.
> > Do you have a read error on your CD ?
> No. I did mention that when I turned off DMA, it worked fine.

I don't see why read errors should lock up the kernel anyway... would it
be acceptable for floppy read errors to lock up the kernel too?

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

