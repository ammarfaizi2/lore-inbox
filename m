Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282112AbRK1JrS>; Wed, 28 Nov 2001 04:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282104AbRK1Jq6>; Wed, 28 Nov 2001 04:46:58 -0500
Received: from [212.65.238.182] ([212.65.238.182]:54538 "EHLO
	trebo3.chemoprojekt.cz") by vger.kernel.org with ESMTP
	id <S282093AbRK1Jq4>; Wed, 28 Nov 2001 04:46:56 -0500
Message-ID: <35E64A70B5ACD511BCB0000000004CA10BD4D6@NT_CHEMO>
From: PVotruba@Chemoprojekt.cz
To: linux-kernel@vger.kernel.org
Subject: RE: 'spurious 8259A interrupt: IRQ7'
Date: Wed, 28 Nov 2001 10:46:51 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also noticed on via686a, duron, geforce2mx, realtek 8029 10 Mbps NIC, ES
1371 sound card, zip drive on paralell port.. Later I'll try to disable
paralell port in bios and see if that strange message disappears...


	--- previous message follows: 
> On Tue, Nov 27, 2001 at 02:38:13PM -0000, Martin A. Brooks wrote:
> 
> > In my research before posting, a common thread seemed to be the presence
> of
> > a tulip card in the machine.  Has anyone seen this on a non-tulip box?
> 
> Yup: standard SuSE 7.3 install on an Asus A7V266-E motherboard (VIA KT266A
> chipset, 512 MB DDR, Athlon XP).
> 
> Just recently installed Linux on that machine (yesterday evening) so I
> don't even know what kernel version SuSE 7.3 uses. :-( If needed, I can
> try
> other kernels.
> 
> -- 
>       Jurjen Oskam * http://www.stupendous.org/ for PGP key * Q265230
>     8:39am  up 30 days, 23:33,  1 user,  load average: 0.15, 0.03, 0.01
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
