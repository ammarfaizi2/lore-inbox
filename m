Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129082AbRBBJ2U>; Fri, 2 Feb 2001 04:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBBJ2K>; Fri, 2 Feb 2001 04:28:10 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:28423 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129082AbRBBJ2B>;
	Fri, 2 Feb 2001 04:28:01 -0500
Date: Fri, 2 Feb 2001 09:26:02 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
Message-ID: <20010202092602.A4837@grobbebol.xs4all.nl>
In-Reply-To: <20010201231652.A2684@grobbebol.xs4all.nl> <E14OTrH-0005Px-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14OTrH-0005Px-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 02, 2001 at 12:13:45AM +0000
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 12:13:45AM +0000, Alan Cox wrote:
> > the used board BP6 (abit), apics enabled. non-overclocked. card is a
> > 
> > 00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL-8029(AS)
> 
> Try 2.4.1ac - that should fix it

ok, downloading the -ac1 patch; I'll report.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
