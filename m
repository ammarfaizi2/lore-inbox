Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKGTlE>; Tue, 7 Nov 2000 14:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQKGTky>; Tue, 7 Nov 2000 14:40:54 -0500
Received: from TRAMPOLINE.THUNK.ORG ([216.175.175.172]:51973 "EHLO
	trampoline.thunk.org") by vger.kernel.org with ESMTP
	id <S129092AbQKGTkv>; Tue, 7 Nov 2000 14:40:51 -0500
Date: Tue, 7 Nov 2000 15:40:47 -0500
Message-Id: <200011072040.eA7Kelw23565@trampoline.thunk.org>
To: david@linux.com
CC: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org, jeremy@goop.org,
        davem@redhat.com, rgooch@atnf.csiro.au, sct@redhat.com
In-Reply-To: <3A03753F.548324A9@linux.com> (message from David Ford on Fri, 03
	Nov 2000 18:32:31 -0800)
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
From: tytso@mit.edu
Phone: (781) 391-3464
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org> <3A033A45.D8F6E952@mandrakesoft.com> <3A03753F.548324A9@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 03 Nov 2000 18:32:31 -0800
   From: David Ford <david@linux.com>

   I reported pcmcia in all forms was broken for test8 on -my hardware-.

   Other kernels such as test10-prex that I'm on now are workable with dhinds
   pcmcia.  I sent you all the requested information you asked for in several
   forms.  The kernel's idea of the the sockets just doesn't work...again, on
   -my hardware-.

   It doesn't matter what voodoo you practice, all of the kernels in the last
   year have been unable to drive -my hardware- in any sort of stable fashion.
   Recent kernels just can't figure out IRQs for the sockets.

Ok, I've refined the PCMCIA comments in the buglist to be more specific.
It wasn't clear that anyone besides David Hinds was working on
stablizing the 2.4 kernel PCMCIA code, and Linus had already said that
he didn't consider it a show-stopper, and that he recommended people use
David's external PCMCIA/Cardbus package anyway.  So I assumed things had
continued to be in a completely broken state, and hadn't bothered to do
more digging into what was going on there.

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
