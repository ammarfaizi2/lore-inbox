Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJBSM>; Tue, 9 Jan 2001 20:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAJBSC>; Tue, 9 Jan 2001 20:18:02 -0500
Received: from chiara.elte.hu ([157.181.150.200]:47116 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129406AbRAJBRy>;
	Tue, 9 Jan 2001 20:17:54 -0500
Date: Wed, 10 Jan 2001 02:17:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hubert Mantel <mantel@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Change of policy for future 2.2 driver submissions
In-Reply-To: <20010110020320.P29904@athlon.random>
Message-ID: <Pine.LNX.4.30.0101100216310.12305-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jan 2001, Andrea Arcangeli wrote:

> > [ the only category impacted are people who are still using the
> > RAID1/RAID4,5 code in the stock 2.2 kernel - i do believe the number of
> 			^^^^^^^^^^^^^^^^^^^^
> That's the category Hubert was talking about indeed.

i understand now - well, there is no reliable RAID1/RAID5 support in the
stock 2.2 kernel indeed, you need the 0.90 patch.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
