Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131383AbRAIR4f>; Tue, 9 Jan 2001 12:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRAIR4Z>; Tue, 9 Jan 2001 12:56:25 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:9223 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129431AbRAIR4N>; Tue, 9 Jan 2001 12:56:13 -0500
Date: Tue, 9 Jan 2001 17:56:11 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101091743090.5932-100000@e2>
Message-ID: <Pine.LNX.4.30.0101091755320.25936-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Ingo Molnar wrote:

> This is one of the busiest and most complex block-IO Linux systems i've
> ever seen, this is why i quoted it - the talk was about block-IO
> performance, and Stephen said that our block IO sucks. It used to suck,
> but in 2.4, with the right patch from Jens, it doesnt suck anymore. )

Is this "right patch from Jens" on the radar for 2.4 inclusion?

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
