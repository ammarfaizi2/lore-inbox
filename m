Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129822AbQKKOm2>; Sat, 11 Nov 2000 09:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130451AbQKKOmS>; Sat, 11 Nov 2000 09:42:18 -0500
Received: from Cantor.suse.de ([194.112.123.193]:37128 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129822AbQKKOmM>;
	Sat, 11 Nov 2000 09:42:12 -0500
Date: Sat, 11 Nov 2000 15:42:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tigran Aivazian <tigran@veritas.com>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001111154209.A3450@inspiron.suse.de>
In-Reply-To: <3A0CB6FD.D4CCE09F@transmeta.com> <Pine.LNX.4.21.0011111133050.1029-100000@saturn.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011111133050.1029-100000@saturn.homenet>; from tigran@veritas.com on Sat, Nov 11, 2000 at 11:36:00AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 11:36:00AM +0000, Tigran Aivazian wrote:
> Are you sure? I thought the fix was to build 2 page tables for 0-8M

Paging is disabled at that point.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
