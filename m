Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130985AbQKIUZX>; Thu, 9 Nov 2000 15:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130876AbQKIUZN>; Thu, 9 Nov 2000 15:25:13 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:31888 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S131152AbQKIUY5>;
	Thu, 9 Nov 2000 15:24:57 -0500
Date: Thu, 9 Nov 2000 15:24:40 -0500
Message-Id: <200011092024.PAA21945@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: paulj@itg.ie, rothwell@holly-springs.nc.us, cr@sap.com,
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: Alan Cox's message of Thu, 9 Nov 2000 14:26:33 +0000 (GMT),
	<E13tsex-0001Cs-00@the-village.bc.nu>
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 9 Nov 2000 14:26:33 +0000 (GMT)
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>

   > Actually, he's been quite specific.  It's ok to have binary modules as
   > long as they conform to the interface defined in /proc/ksyms.  

   What is completely unclear is if he has the authority to say that given that
   there is code from other people including the FSF merged into the
   tree.

He said it long enough ago that presumably people who merged code in
would have accepted it as an implicit agreement, if it had been
documented in the COPYING file.  Unfortuantely, it wasn't so documented,
so I agree it's unclear.

   I've taken to telling folks who ask about binary modules to talk to
   their legal department. The whole question is simply to complicated
   for anyone else to work on.

... and at that point we run intothe oft-debated (but never tested in a
court of law) question of into the whether or not Copyright can infect
across a link, especially since the link is done by the end-user.  (Yes,
there are some questions about inline functions in the header files.)

The intent of what the FSF would like the case to be is clear, but it's
not clear at all that Copyright law works that way; intent doesn't
matter if the laws don't give you the right to sue on those grounds.
See a lawyer and get official legal advice indeed....


						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
