Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQJ3KWV>; Mon, 30 Oct 2000 05:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129238AbQJ3KWM>; Mon, 30 Oct 2000 05:22:12 -0500
Received: from chiara.elte.hu ([157.181.150.200]:52742 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129213AbQJ3KV5>;
	Mon, 30 Oct 2000 05:21:57 -0500
Date: Mon, 30 Oct 2000 12:31:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030030625.C20271@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301225490.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> Ingo, This original thread was regarding Linux vs. NetWare 5.x
> performance metrics and responses from Linux folks about how to affect
> and improve them, not a diatribe on the features of TUX.

oh, i believe you misunderstand. TUX itself is quite simple. But it
extended the Linux TCP stack and scalability to new levels (which has
nothing to do with TUX itself, it's the scalability of the Linux
networking stack that evolved gradually over the past 10 years - we spend
95% of the time outside of TUX!). And if you claim that Linux needs this
and that for scalability, then i'd like to point you humbly towards those
existing, generic and well-performing results. TUX is just a 5% 'HTTP
protocol fluff' around the generic stuff.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
