Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQK3UnI>; Thu, 30 Nov 2000 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129257AbQK3Um6>; Thu, 30 Nov 2000 15:42:58 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:9202 "EHLO
        webber.adilger.net") by vger.kernel.org with ESMTP
        id <S129183AbQK3Umq>; Thu, 30 Nov 2000 15:42:46 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011302012.eAUKCG201943@webber.adilger.net>
Subject: Re: DVD on Linux
In-Reply-To: <002a01c05ae5$e4fefa60$7930000a@hcd.net> "from Timothy A. DeWees
 at Nov 30, 2000 10:54:54 am"
To: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
Date: Thu, 30 Nov 2000 13:12:16 -0700 (MST)
CC: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy A. DeWees writes:
>     Can someone please point me to a doc on how to mount a DVD drive.
> COrrect me if I am wrong but the DVD file format is UDF?  I did not see that
> as an option when I compiled 2.2.17.  Do I need to use 2.4.0testX to mount
> DVD's?  Thanks in advance!

UDF is an extra patch for 2.2 kernels (it _may_ be in 2.2.18, I don't recall).
It is standard on 2.4.  You can get the UDF patches at sourceforge, IIRC.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
