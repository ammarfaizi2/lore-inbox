Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLVR2B>; Fri, 22 Dec 2000 12:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQLVR1l>; Fri, 22 Dec 2000 12:27:41 -0500
Received: from inet.connecttech.com ([206.130.75.2]:1218 "EHLO
	inet.connecttech.com") by vger.kernel.org with ESMTP
	id <S129458AbQLVR1g>; Fri, 22 Dec 2000 12:27:36 -0500
Message-ID: <00c301c06c38$814ab860$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Matthias Andree" <matthias.andree@gmx.de>,
        "Andrea Arcangeli" <andrea@suse.de>
Cc: "Linux-Kernel mailing list" <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@valinux.com>
In-Reply-To: <20001222154757.A1167@emma1.emma.line.org> <20001222162159.A29397@athlon.random> <20001222173538.A12949@krusty.e-technik.uni-dortmund.de>
Subject: Re: FAIL: 2.2.18 + AA-VM-global-7 + serial 5.05
Date: Fri, 22 Dec 2000 11:59:10 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthias Andree" <matthias.andree@gmx.de>
> 3. patch the kernel with that 2.2.18-fix-serial-5.05-pre.patch, it takes
>    a high fuzz factor (try patch -p1 -F10)
> 4. unpack serial-5.05

I don't have permission to fetch
2.2.18-fix-serial-5.05-pre.patch
at
http://www-dt.e-technik.uni-dortmund.de/~ma/kernelpatches/v2.2/v2.2.18/

What file does step 3 modify? It's likely this patch is being overwritten
(lost) in step 4. Probably not the source of the problem though.

..Stu


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
