Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbQJaUZN>; Tue, 31 Oct 2000 15:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbQJaUZD>; Tue, 31 Oct 2000 15:25:03 -0500
Received: from chiara.elte.hu ([157.181.150.200]:41735 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130113AbQJaUYt>;
	Tue, 31 Oct 2000 15:24:49 -0500
Date: Tue, 31 Oct 2000 22:34:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001031195012.A138@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0010312231490.15159-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Pavel Machek wrote:

> > Excuse me, 857,000,000 instructions executed and 460,000,000
> > context switches a second -- on a PII system at 350 Mhz. [...]

> That's more than one context switch per clock. I do not think so.
> Really go and check those numbers.

yep, you cannot have 460 million context switches on that system,
unless you have some Clintonesque definition for 'context switch' ;-)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
