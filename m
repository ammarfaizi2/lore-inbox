Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130444AbQKKAMM>; Fri, 10 Nov 2000 19:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131610AbQKKAMC>; Fri, 10 Nov 2000 19:12:02 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:14084 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130444AbQKKALt>;
	Fri, 10 Nov 2000 19:11:49 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011110011.eAB0BbF244111@saturn.cs.uml.edu>
Subject: Re: Where is it written?
To: meissner@spectacle-pond.org (Michael Meissner)
Date: Fri, 10 Nov 2000 19:11:37 -0500 (EST)
Cc: george@mvista.com (George Anzinger),
        linux-kernel@vger.kernel.org (linux-kernel@vger.redhat.com)
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> from "Michael Meissner" at Nov 10, 2000 06:40:31 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Meissner writes:

> It may be out of print by now, but the original reference
> for the x86 ABI, is the:
>
> 	System V Application Binary Interface
> 	Intel386 (tm) Processor Supplement
>
> When Cygnus purchased the manual I have, many moons ago,
> it was published by AT&T, with a copyright date of 1991,

Gee that looks old. Might there be better calling conventions
for the Pentium 4 or Athlon? Memory latency, vector registers,
and more direct access to floating-point registers may mean
we ought to change the calling conventions. One would start
with the kernel of course, because it stands alone.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
