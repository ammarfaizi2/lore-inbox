Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbQJ3KDU>; Mon, 30 Oct 2000 05:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbQJ3KDK>; Mon, 30 Oct 2000 05:03:10 -0500
Received: from chiara.elte.hu ([157.181.150.200]:51718 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129280AbQJ3KCz>;
	Mon, 30 Oct 2000 05:02:55 -0500
Date: Mon, 30 Oct 2000 12:12:44 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030025424.A20271@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301208230.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> > > Excuse me, 857,000,000 instructions executed and 460,000,000 context switches
> > > a second -- on a PII system at 350 Mhz. [...]

> Go download it and try it, then come back with that smirk wiped off
> your face. I'll enjoy it.....

so in 0.53 clock cycles you are implementing things like address space
separation, process priorities, fairness and other essential scheduling
features? Truly awesome ...

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
