Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136717AbRAMMhv>; Sat, 13 Jan 2001 07:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136733AbRAMMhl>; Sat, 13 Jan 2001 07:37:41 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:25315 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S136717AbRAMMh1>;
	Sat, 13 Jan 2001 07:37:27 -0500
Date: Sat, 13 Jan 2001 12:20:50 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: "V.P." <vpedro@individual.EUnet.pt>, linux-kernel@vger.kernel.org
Subject: Re: APIC ERRor on CPU0: 00(02) ...
Message-ID: <20010113122050.A1300@grobbebol.xs4all.nl>
In-Reply-To: <3A5F172D.8C77E17@individual.EUnet.pt> <Pine.LNX.4.21.0101121425350.18375-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101121425350.18375-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Fri, Jan 12, 2001 at 02:27:07PM -0800
X-OS: Linux grobbebol 2.2.19pre7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 02:27:07PM -0800, Dr. Kelsey Hudson wrote:
> 
> This is due to your piece of trash motherboard. The reason that the older
> kernel didn't catch these errors is because (IIRC) it wasn't looking for
> them; they were there even then. The BP6 is a low-end mainboard and was
> engineered very poorly; these errors are due to that fact alone.

you can say about the BP6 what you want but it appears that there are
(if your vision is right) many other low end SMP boards categorized
trash. there has been one mistake with it and that's the capacitor
behind a regulator that may have been mis-dimentioned due to the
partchange of that particular capacitor.

my 2.2 kernel running on the BP6 proves that it may work very well,
unless you think that uptimes of > 40 days is bad.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
