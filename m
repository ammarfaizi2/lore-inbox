Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRAJBDa>; Tue, 9 Jan 2001 20:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132630AbRAJBDV>; Tue, 9 Jan 2001 20:03:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33332 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131958AbRAJBDM>; Tue, 9 Jan 2001 20:03:12 -0500
Date: Wed, 10 Jan 2001 02:03:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hubert Mantel <mantel@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
Message-ID: <20010110020320.P29904@athlon.random>
In-Reply-To: <20010109154908.F20539@suse.de> <Pine.LNX.4.30.0101100128420.11738-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101100128420.11738-100000@e2>; from mingo@elte.hu on Wed, Jan 10, 2001 at 01:33:10AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 9 Jan 2001, Hubert Mantel wrote:
> > Right, but now there is a problem: Software RAID. The RAID code of
> > 2.4.0 is not backwards compatible to the one in 2.2.18; if somebody
> > has used 2.4.0 on softraid and discovers some problem, he can not
> > switch back to some official 2.2 kernel. [...]
		   ^^^^^^^^^^^^^^^^^^^^^^^^

On Wed, Jan 10, 2001 at 01:33:10AM +0100, Ingo Molnar wrote:
> [ the only category impacted are people who are still using the
> RAID1/RAID4,5 code in the stock 2.2 kernel - i do believe the number of
			^^^^^^^^^^^^^^^^^^^^

That's the category Hubert was talking about indeed.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
