Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129625AbQK1BZb>; Mon, 27 Nov 2000 20:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129904AbQK1BZV>; Mon, 27 Nov 2000 20:25:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40458 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129625AbQK1BZO>; Mon, 27 Nov 2000 20:25:14 -0500
Subject: Re: 2.4.0-test11-ac2 and ac4 SMP will not run KDE 2.0
To: scole@lanl.gov
Date: Tue, 28 Nov 2000 00:55:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <00112716232501.00953@spc.esa.lanl.gov> from "Steven Cole" at Nov 27, 2000 04:23:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140Z3a-0003qU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For what its worth, on my single processor home machine, all kernels
> 2.4.0-test11-ac1,ac2,ac3, ac4 both UP and SMP run both Gnome and
> KDE 2.0, with reiserfs-3.6.19.  In other words, everything works with
> everything. 

Nod. It actually puzzles me since from the kernel view I doubt kde and gnome
even look different at the syscall level. They may look different to X but
X isnt the thing that changed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
