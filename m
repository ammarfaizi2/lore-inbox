Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQKKF3Z>; Sat, 11 Nov 2000 00:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbQKKF3P>; Sat, 11 Nov 2000 00:29:15 -0500
Received: from harrier.prod.itd.earthlink.net ([207.217.121.12]:17291 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129669AbQKKF3A>; Sat, 11 Nov 2000 00:29:00 -0500
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Max Inux <maxinux@bigfoot.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.30.0011101822120.10847-100000@shambat>
	<3A0CB6FD.D4CCE09F@transmeta.com>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 10 Nov 2000 21:28:44 -0800
In-Reply-To: <3A0CB6FD.D4CCE09F@transmeta.com>
Message-ID: <m3y9yrf56b.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@transmeta.com> writes:

> > On x86 machines there is a size limitation on booting.  Though I thought
> > it was 1024K as the max, 900K should be fine.
> No, there isn't.  There used to be, but it has been fixed.

the main problem is for us distribution if we want to fit this on a
disk with a couple of modules for our installation process.

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
