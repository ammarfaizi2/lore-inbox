Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129582AbQK0UjD>; Mon, 27 Nov 2000 15:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129707AbQK0Uiy>; Mon, 27 Nov 2000 15:38:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16507 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129582AbQK0Uim>; Mon, 27 Nov 2000 15:38:42 -0500
Subject: Re: 2.4.0-test11-ac2 and ac4 SMP will not run KDE 2.0
To: scole@lanl.gov
Date: Mon, 27 Nov 2000 20:08:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00112713015500.00953@spc.esa.lanl.gov> from "Steven Cole" at Nov 27, 2000 01:01:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140UaD-0003ZI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I try to start KDE 2.0 with SMP builds
> of 2.4.0-test11-ac2 and ac4, the system locks up
> after "Loading Panel". Nothing odd gets logged
> to /var/log/messages.
> Precision 420 Dual P-III. All kernels are patched with
> linux-2.4.0-test10-reiserfs-3.6.19-patch.

I don't test -ac kernel trees with reiserfs. I don't really have time. Can
you or others reproduce the same report on an unmodified tree.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
