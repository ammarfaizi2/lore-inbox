Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131067AbRAMSZA>; Sat, 13 Jan 2001 13:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130660AbRAMSYv>; Sat, 13 Jan 2001 13:24:51 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130562AbRAMSYd>;
	Sat, 13 Jan 2001 13:24:33 -0500
To: david+validemail@kalifornia.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmem or swapfs? was: [Patch] make shm filesystem part configurable
In-Reply-To: <m366jj20si.fsf@linux.local> <3A604B26.53EC029F@linux.com>
	<m33denk0p2.fsf@linux.local> <3A60634A.54BB21ED@linux.com>
From: Christoph Rohland <cr@sap.com>
Date: 13 Jan 2001 17:51:56 +0100
Message-ID: <m38zofiedv.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david@linux.com> writes:

> Hmm, ok, what are the activities that use this other than shm?

You can e.g. use it for your /tmp filesystem. there seem to be some
people out there which used ramfs for that...

What do you think about "vmfs"? This probably reflects its nature
better than swapfs.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
