Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKBTxR>; Thu, 2 Nov 2000 14:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbQKBTxH>; Thu, 2 Nov 2000 14:53:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:36651 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129183AbQKBTxB>; Thu, 2 Nov 2000 14:53:01 -0500
Date: Thu, 2 Nov 2000 20:52:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tim Riker <Tim@Rikers.org>
Cc: Andi Kleen <ak@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
Message-ID: <20001102205246.A17332@athlon.random>
In-Reply-To: <3A01B8BB.A17FE178@Rikers.org> <E13rPhi-0001ng-00@the-village.bc.nu> <20001102201836.A14409@gruyere.muc.suse.de> <3A01BDCD.FCBCFFF8@Rikers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A01BDCD.FCBCFFF8@Rikers.org>; from Tim@Rikers.org on Thu, Nov 02, 2000 at 12:17:33PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 12:17:33PM -0700, Tim Riker wrote:
> [..] by adding gcc
> syntax into it [..]

I think that's the right path. How much would be hard for you to add gcc syntax
into your compiler too instead of feeding us kernel patches? Note that it would
be a big advantage also for userspace (not only kernel uses inline asm and
other gcc extensions). And probably it would be an improvement to your
compiler too (since I don't know of other compilers that are as smart as
gcc in the inline asm syntax :).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
