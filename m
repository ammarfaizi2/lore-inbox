Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131828AbQKKStn>; Sat, 11 Nov 2000 13:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131942AbQKKStd>; Sat, 11 Nov 2000 13:49:33 -0500
Received: from Cantor.suse.de ([194.112.123.193]:41234 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131828AbQKKSt3>;
	Sat, 11 Nov 2000 13:49:29 -0500
Date: Sat, 11 Nov 2000 19:47:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Tigran Aivazian <tigran@veritas.com>, "H. Peter Anvin" <hpa@transmeta.com>,
        Max Inux <maxinux@bigfoot.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001111194707.A831@inspiron.suse.de>
In-Reply-To: <20001111172610.A9140@inspiron.suse.de> <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet>; from tigran@aivazian.fsnet.co.uk on Sat, Nov 11, 2000 at 04:46:09PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 04:46:09PM +0000, Tigran Aivazian wrote:
> I understand and agree with what you say except the number 4M. It is not
> 4M but 8M, imho. See arch/i386/kernel/head.S

You're reading 2.4.x, I was reading 2.2.x.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
