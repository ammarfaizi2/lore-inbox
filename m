Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbQJ3JzL>; Mon, 30 Oct 2000 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129230AbQJ3JzA>; Mon, 30 Oct 2000 04:55:00 -0500
Received: from chiara.elte.hu ([157.181.150.200]:50182 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129110AbQJ3Jyy>;
	Mon, 30 Oct 2000 04:54:54 -0500
Date: Mon, 30 Oct 2000 12:04:43 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030023339.A20102@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301150390.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> It's not curious, it's not about bandwidth, it's about latency, and
> getting packets in and out of the server as fast as possible, and
> ahead of everything else. [...]

TUX prepares a HTTP reply in about 30 microseconds (plus network latency),
good enough? Network latency is the limit, even on gigabit - not to talk
about T1 lines.

	Ingo


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
