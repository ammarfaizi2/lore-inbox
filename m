Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKHDg4>; Tue, 7 Nov 2000 22:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbQKHDgr>; Tue, 7 Nov 2000 22:36:47 -0500
Received: from swan.prod.itd.earthlink.net ([207.217.120.123]:29874 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129091AbQKHDgl>; Tue, 7 Nov 2000 22:36:41 -0500
To: Sean Middleditch <sean.middleditch@iname.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic - weird error
In-Reply-To: <3A05A724.216E04F3@iname.com>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 07 Nov 2000 19:36:33 -0800
In-Reply-To: <3A05A724.216E04F3@iname.com>
Message-ID: <m3snp3jfsu.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Middleditch <sean.middleditch@iname.com> writes:

> I've installed the Linux-Mandrake 7.2 distro (which uses kernel version
> 2.2.17) on a PIII system (Asus motherboard, Award Medallion v6.0 BIOS).
> For some reason, neither LILO nor Grub were able to boot off of the
> second hard-drive (where Linux is).  I've copied over the kernel, and a
> few other LILO files to a Windows partition on the primary drive.  Now,
> LILO can load the kernel, and the kernel begins to boot.
> 
> First, I noticed this during the IDE detection:
>   hdd [PTBL] [784/255/53] hdd1 < hdd5 hdd6 >
> I've never seen the "[PTBL] [784/255/53]" part before on any Linux
> system, so I was unsure if this was important.

have you enabled the optimization ? which add the autotune options
and do some time weird thing.

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
