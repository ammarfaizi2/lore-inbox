Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132363AbRBKLXo>; Sun, 11 Feb 2001 06:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132364AbRBKLXZ>; Sun, 11 Feb 2001 06:23:25 -0500
Received: from smtp1.xs4all.nl ([194.109.127.131]:19717 "EHLO smtp1.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132363AbRBKLXP>;
	Sun, 11 Feb 2001 06:23:15 -0500
Date: Sun, 11 Feb 2001 11:22:18 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: john slee <indigoid@higherplane.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: hard lockup (no oops) on vanilla 2.4.2-pre3 with /dev/dsp
Message-ID: <20010211112218.A918@grobbebol.xs4all.nl>
In-Reply-To: <20010211053145.A748@higherplane.net> <E14RfmM-0002Ao-00@the-village.bc.nu> <20010211222032.A975@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010211222032.A975@higherplane.net>; from indigoid@higherplane.net on Sun, Feb 11, 2001 at 10:20:33PM +1100
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 10:20:33PM +1100, john slee wrote:
> i'm fairly sure its not ram at fault, since nothing else is acting
> strangely, and it only crops up when i use /dev/dsp.
> 
> anything else i can try to narrow it down?  this is just a home
> workstation, so i can try practically anything if necessary.


I missed this thread a bit but I also am experiencing problems when
using sound (playing mp3's) -- hard crashes. I am not sure wether it's X
related (xmms/X v4.0x), sound related (opensound drivers), hardware
related (dual BP6, non OC with apic patches).

could you mail privately what the issues are ? maybe I have the same
problems.
-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
