Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRBBLgV>; Fri, 2 Feb 2001 06:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129442AbRBBLgM>; Fri, 2 Feb 2001 06:36:12 -0500
Received: from smtp7.xs4all.nl ([194.109.127.133]:48858 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129431AbRBBLgG>;
	Fri, 2 Feb 2001 06:36:06 -0500
Date: Fri, 2 Feb 2001 10:58:24 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
Message-ID: <20010202105824.A2288@grobbebol.xs4all.nl>
In-Reply-To: <20010201231652.A2684@grobbebol.xs4all.nl> <E14OTrH-0005Px-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14OTrH-0005Px-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 02, 2001 at 12:13:45AM +0000
X-OS: Linux grobbebol 2.4.1-ac1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 12:13:45AM +0000, Alan Cox wrote:
> > the used board BP6 (abit), apics enabled. non-overclocked. card is a
> > 
> > 00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL-8029(AS)
> 
> Try 2.4.1ac - that should fix it

ok, it doesn't crash (the first test) but.... the ne2k also doesn't work
anymore after approx 1000 interrupts.

I'll see if normal use (e.g. no floodping) helps here.
[later.... xferred approx 300 MBytes. initially looks "good"]

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
