Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135510AbRAJNcm>; Wed, 10 Jan 2001 08:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135593AbRAJNcc>; Wed, 10 Jan 2001 08:32:32 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31794 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135510AbRAJNc1>; Wed, 10 Jan 2001 08:32:27 -0500
Date: Wed, 10 Jan 2001 14:32:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, acahalanrth@twiddle.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
Message-ID: <20010110143234.C15140@athlon.random>
In-Reply-To: <20010110032048.B9486@athlon.random> <Pine.LNX.4.10.10101092304410.3414-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101092304410.3414-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 09, 2001 at 11:10:37PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 11:10:37PM -0800, Linus Torvalds wrote:
> I have to say, I think it was Pascal had this "no semicolon needed before
> an 'end'" rule, and I always really hated that. The C statement rules make

Me too ;)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
