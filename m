Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKRT7s>; Sat, 18 Nov 2000 14:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbQKRT7j>; Sat, 18 Nov 2000 14:59:39 -0500
Received: from snipe.prod.itd.earthlink.net ([207.217.120.62]:37117 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129171AbQKRT73>; Sat, 18 Nov 2000 14:59:29 -0500
To: Dave Seff <dseff@bloomberg.com>
Cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: Re: Kernel Panic
In-Reply-To: <00111712441100.05390@jupiter>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 18 Nov 2000 11:29:09 -0800
In-Reply-To: <00111712441100.05390@jupiter>
Message-ID: <m3vgtlyt8a.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Seff <dseff@bloomberg.com> writes:

> I am not subscribed to this list, so please cc me on
> replies. Thanks.  I was running mke2fs on an external 17GB SCSI
> drive. This started spewing and blasted the 2.2.17mdksmp kernel.


could you generate it with ksymoops(include kernel-utils rpm) like explain in :

/usr/src/linux-2.2.17/REPORTING-BUGS

> ncr53c896-0:2: ERROR (0:4) (8-0-0) (0/f) @ (script 42c:0f000001).
> ncr53c896-0: script cmd = 71500000 ncr53c896-0: regdump: da 00 80 0f
> 47 00 02 0b 81 00 82 00 80 00 08 02.

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
