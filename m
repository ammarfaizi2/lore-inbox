Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBIXs6>; Fri, 9 Feb 2001 18:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBIXsr>; Fri, 9 Feb 2001 18:48:47 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:64191 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129093AbRBIXsc>; Fri, 9 Feb 2001 18:48:32 -0500
Message-ID: <3A8481C0.2756BA1D@Home.net>
Date: Fri, 09 Feb 2001 18:48:17 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre3
In-Reply-To: <Pine.LNX.4.10.10102091531550.22341-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

haha thats funny, I just compiled 2.4.2-pre2 ;-)

oh well...time to patch again.


Linus Torvalds wrote:

> Nothing too radical here..
>
>                 Linus
>
> ----
> -pre3:
>  - Jens: better ordering of requests when unable to merge
>  - Neil Brown: make md work as a module again (we cannot autodetect
>    in modules, not enough background information)
>  - Neil Brown: raid5 SMP locking cleanups
>  - Neil Brown: nfsd: handle Irix NFS clients named pipe behavior and
>    dentry leak fix
>  - maestro3 shutdown fix
>  - fix dcache hash calculation that could cause bad hashes under certain
>    circumstances (Dean Gaudet)
>  - David Miller: networking and sparc updates
>  - Jeff Garzik: include file cleanups
>  - Andy Grover: ACPI update
>  - Coda-fs error return fixes
>  - rth: alpha Jensen update
>
> -pre2:
>  - driver sync up with Alan
>  - Andrew Morton: wakeup cleanup and race fix
>  - Paul Mackerras: macintosh driver updates.
>  - don't trust "page_count()" on reserved pages!
>  - Russell King: fix serious IDE multimode write bug!
>  - me, Jens, others: fix elevator problem
>  - ARM, MIPS and cris architecture updates
>  - alpha updates: better page clear/copy, avoid kernel lock in execve
>  - USB and firewire updates
>  - ISDN updates
>  - Irda updates
>
> -pre1:
>  - XMM: don't allow illegal mxcsr values
>  - ACPI: handle non-existent battery strings gracefully
>  - Compaq Smart Array driver update
>  - Kanoj Sarcar: serial console hardware flow control support
>  - ide-cs: revert toc-valid cache checking in 2.4.1
>  - Vojtech Pavlik: update via82cxxx driver to handle the vt82c686
>  - raid5 graceful failure handling fix
>  - ne2k-pci: enable device before asking the irq number
>  - sis900 driver update
>  - riva FB driver update
>  - fix silly inode hashing pessimization
>  - add SO_ACCEPTCONN for SuS
>  - remove modinfo hack workaround, all newer modutils do it correctly
>  - datagram socket shutdown fix
>  - mark process as running when it takes a page-fault
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
