Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279483AbRJXHjB>; Wed, 24 Oct 2001 03:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279457AbRJXHiv>; Wed, 24 Oct 2001 03:38:51 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:48294 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S279482AbRJXHif> convert rfc822-to-8bit; Wed, 24 Oct 2001 03:38:35 -0400
Subject: Re: linux-2.4.13..
From: christophe barbe <christophe.barbe.ml@online.fr>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.15 (Preview Release)
Date: 24 Oct 2001 09:39:05 +0200
Message-Id: <1003909145.1101.9.camel@turing>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Normally we send only failure reports but after the 2.4.11 and 2.4.12 I
would like to thank you, Linus, for you dedication.
I enjoy the linux kernel as a OS user and as a source code reader (as
far as I can).

2.4.13 builds and boots perfectly for me.

Christophe Barbé ...

PS: If the DMCA and other scary stuff bother you too much, what about
exiling in Paris in France ;-)

le mer 24-10-2001 at 07:52 Linus Torvalds a écrit :
> 
> Things seem to be calming down a bit, which is nice.
> 
> Of course, it might possibly also be that everybody is off flaming about
> the DMCA and getting no work done ;)
> 
> Whatever the cause, here's a 2.4.13. See if you can break it,
> 
> 		Linus
> 
> ----
> final:
>  - page write-out throttling
>  - Pete Zaitcev: ymfpci sound driver update (make Civ:CTP happy with it)
>  - Alan Cox: i2o sync-up
>  - Andrea Arcangeli: revert broken x86 smp_call_function patch
>  - me: handle VM write load more gracefully. Merge parts of -aa VM
> 
> pre6:
>  - Stephen Rothwell: APM idle time handling fixes, docbook update, cleanup
>  - Jeff Garzik: network driver updates
>  - Greg KH: USB updates
>  - Al Viro: UFS update, binfmt_misc rewrite.
>  - Andreas Dilger: /dev/random fixes
>  - David Miller: network/sparc updates
> 
> pre5:
>  - Greg KH: usbnet fix
>  - Johannes Erdfelt: uhci.c bulk queueing fixes
> 
> pre4:
>  - Al Viro: mnt_list init
>  - Jeff Garzik: network driver update (license tags, tulip driver)
>  - David Miller: sparc, net updates
>  - Ben Collins: firewire update
>  - Gerd Knorr: btaudio/bttv update
>  - Tim Hockin: MD cleanups
>  - Greg KH, Petko Manolov: USB updates
>  - Leonard Zubkoff: DAC960 driver update
> 
> pre3:
>  - Jens Axboe: clean up duplicate unused request list
>  - Jeff Mahoney: reiserfs endianness finishing touches
>  - Hugh Dickins: some further swapoff fixes and cleanups
>  - prepare-for-Alan: move drivers/i2o into drivers/message/i2o
>  - Leonard Zubkoff: 2TB disk device fixes
>  - Paul Schroeder: mwave config enable
>  - Urban Widmark: fix via-rhine double free..
>  - Tom Rini: PPC fixes
>  - NIIBE Yutaka: SuperH update
> 
> pre2:
>  - Alan Cox: more merging
>  - Ben Fennema: UDF module license
>  - Jeff Mahoney: reiserfs endian safeness
>  - Chris Mason: reiserfs O_SYNC/fsync performance improvements
>  - Jean Tourrilhes: wireless extension update
>  - Joerg Reuter: AX.25 updates
>  - David Miller: 64-bit DMA interfaces
> 
> pre1:
>  - Trond Myklebust: deadlock checking in lockd server
>  - Tim Waugh: fix up parport wrong #define
>  - Christoph Hellwig: i2c update, ext2 cleanup
>  - Al Viro: fix partition handling sanity check.
>  - Trond Myklebust: make NFS use SLAB_NOFS, and not play games with PF_MEMALLOC
>  - Ben Fennema: UDF update
>  - Alan Cox: continued merging
>  - Chris Mason: get /proc buffer memory sizes right after buf-in-page-cache
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

