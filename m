Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLWKyg>; Sat, 23 Dec 2000 05:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQLWKy0>; Sat, 23 Dec 2000 05:54:26 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26886 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129340AbQLWKyO>; Sat, 23 Dec 2000 05:54:14 -0500
Subject: Re: test13-pre4-ac2 - part of diff fails
To: daniel@kabuki.eyep.net (Daniel Stone)
Date: Sat, 23 Dec 2000 10:25:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001223030539Z131141-439+5796@vger.kernel.org> from "Daniel Stone" at Dec 23, 2000 01:37:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E149ls4-0005x3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> patching file arch/i386/kernel/smp.c
> Reversed (or previously applied) patch detected!  Assume -R? [n] 
> Apply anyway? [n] y
> Hunk #1 FAILED at 278.
> Hunk #2 succeeded at 511 (offset 9 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file arch/i386/kernel/smp.c.rej
> 
> Works fine if I reverse it and then put it back in. ?

Its a bug in my patch - get 13pre4ac2 ..
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
