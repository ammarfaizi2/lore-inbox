Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJBkg>; Tue, 9 Jan 2001 20:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbRAJBk1>; Tue, 9 Jan 2001 20:40:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17722 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129431AbRAJBkR>; Tue, 9 Jan 2001 20:40:17 -0500
Date: Wed, 10 Jan 2001 02:40:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hubert Mantel <mantel@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
Message-ID: <20010110024029.Q29904@athlon.random>
In-Reply-To: <20010110020320.P29904@athlon.random> <Pine.LNX.4.30.0101100216310.12305-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101100216310.12305-100000@e2>; from mingo@elte.hu on Wed, Jan 10, 2001 at 02:17:35AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 02:17:35AM +0100, Ingo Molnar wrote:
> i understand now - well, there is no reliable RAID1/RAID5 support in the
> stock 2.2 kernel indeed, you need the 0.90 patch.

I used raid1 without problems in stock 2.2 kernel. For raid5 I certainly
agree ;).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
