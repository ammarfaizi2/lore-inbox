Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129298AbQKLQWk>; Sun, 12 Nov 2000 11:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQKLQWb>; Sun, 12 Nov 2000 11:22:31 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31090 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129298AbQKLQWY>; Sun, 12 Nov 2000 11:22:24 -0500
Date: Sun, 12 Nov 2000 17:22:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Tigran Aivazian <tigran@veritas.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001112172225.F4933@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0011111133050.1029-100000@saturn.homenet> <3A0DA785.C69F1EA1@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A0DA785.C69F1EA1@transmeta.com>; from hpa@transmeta.com on Sat, Nov 11, 2000 at 12:09:41PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 12:09:41PM -0800, H. Peter Anvin wrote:
> a while), but you're right, for now the limit is 8 MB *uncompressed.*

s/8/7/ (kernel starts at 1M)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
