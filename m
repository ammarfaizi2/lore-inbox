Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129625AbQKUGYR>; Tue, 21 Nov 2000 01:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129663AbQKUGYH>; Tue, 21 Nov 2000 01:24:07 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:54532 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129625AbQKUGX7>;
	Tue, 21 Nov 2000 01:23:59 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011210553.eAL5rv0311508@saturn.cs.uml.edu>
Subject: Re: Defective Red Hat Distribution poorly represents Linux
To: maillist@chello.nl (Igmar Palsenberg)
Date: Tue, 21 Nov 2000 00:53:57 -0500 (EST)
Cc: cturner@quark.analogic.com (Charles Turner Ph.D.),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011202113220.10587-100000@server.serve.me.nl> from "Igmar Palsenberg" at Nov 20, 2000 09:15:47 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These are hardware problems, not software. Programs like gcc and ld
> segfaulting like this is NOT a software problem. 
> 
> Please don't turn up with some 'hey, it worked with my disk', that's no
> clue that the distrib is bad. The same arguments as 'it works with
> Windows'. 

This could be a Linux kernel problem. (though likely not)

If one disk works and another one not, one might suspect
that the wrong DMA mode is being used in the crashing case.
The easy fix: replace the drive with a different model, and
make sure you have the most modern cables.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
