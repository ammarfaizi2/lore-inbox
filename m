Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129656AbQK0Xx5>; Mon, 27 Nov 2000 18:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129799AbQK0Xxq>; Mon, 27 Nov 2000 18:53:46 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:785 "EHLO tstac.esa.lanl.gov")
        by vger.kernel.org with ESMTP id <S129656AbQK0Xxf>;
        Mon, 27 Nov 2000 18:53:35 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Mon, 27 Nov 2000 16:23:25 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E140UaD-0003ZI-00@the-village.bc.nu>
In-Reply-To: <E140UaD-0003ZI-00@the-village.bc.nu>
Subject: Re: 2.4.0-test11-ac2 and ac4 SMP will not run KDE 2.0
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00112716232501.00953@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 November 2000 13:08, Alan Cox wrote:

> > Precision 420 Dual P-III. All kernels are patched with
> > linux-2.4.0-test10-reiserfs-3.6.19-patch.
>
> I don't test -ac kernel trees with reiserfs. I don't really have time. Can
> you or others reproduce the same report on an unmodified tree.
>
> Alan

I will have to acquire another suitable disk to reproduce this problem
using an unmodified tree.  If anyone can help, I'd appreciate it.  Thanks
in advance.  If not, I'll try to reproduce it when I can get the hardware.

For what its worth, on my single processor home machine, all kernels
2.4.0-test11-ac1,ac2,ac3, ac4 both UP and SMP run both Gnome and
KDE 2.0, with reiserfs-3.6.19.  In other words, everything works with
everything. 

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
