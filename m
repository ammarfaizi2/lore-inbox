Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRAJAZy>; Tue, 9 Jan 2001 19:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130415AbRAJAZp>; Tue, 9 Jan 2001 19:25:45 -0500
Received: from chiara.elte.hu ([157.181.150.200]:44556 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131150AbRAJAZb>;
	Tue, 9 Jan 2001 19:25:31 -0500
Date: Wed, 10 Jan 2001 01:24:17 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Kaiser <rob@sysgo.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <Pine.LNX.4.30.0101100109270.11542-100000@e2>
Message-ID: <Pine.LNX.4.30.0101100122580.11651-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you should also try to access the mem_map variable directly, in some
simple way. Could you print out the value of mem_map btw.? [This should
rule out any compiler interaction.]

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
