Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKGTSH>; Tue, 7 Nov 2000 14:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129043AbQKGTR5>; Tue, 7 Nov 2000 14:17:57 -0500
Received: from TRAMPOLINE.THUNK.ORG ([216.175.175.172]:45573 "EHLO
	trampoline.thunk.org") by vger.kernel.org with ESMTP
	id <S129033AbQKGTRr>; Tue, 7 Nov 2000 14:17:47 -0500
Date: Tue, 7 Nov 2000 15:17:38 -0500
Message-Id: <200011072017.eA7KHcm23505@trampoline.thunk.org>
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu> (message from Alan Cox on
	Fri, 3 Nov 2000 15:53:34 +0000 (GMT))
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
From: tytso@mit.edu
Phone: (781) 391-3464
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 3 Nov 2000 15:53:34 +0000 (GMT)
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>

   >      * AIC7xxx doesnt work non PCI ? (Doug says OK, new version due
   >        anyway)

   This is now in Justin Gibbs hand but will take time to move on. Doug
   confirmed his current code is now merged too.

Does this mean that the problem has been fixed in the latest 2.4 tree?
i.e., Does Doug's current code have the problem fixed?

   >      * Issue with notifiers that try to deregister themselves? (lnz;
   >        notifier locking change by Garzik should backed out, according to
   >        Jeff)

   and according to Alan

But it hasn't been backed out yet, correct?  

Someone one send a patch to Linus?

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
