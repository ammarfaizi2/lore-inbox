Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131184AbQL3Fp5>; Sat, 30 Dec 2000 00:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131865AbQL3Fps>; Sat, 30 Dec 2000 00:45:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13321 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131184AbQL3Fpb>; Sat, 30 Dec 2000 00:45:31 -0500
Date: Fri, 29 Dec 2000 21:13:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Byron Stanoszek <gandalf@winds.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre6 (Fork Bug with Athlons? Temporary Fix)
In-Reply-To: <Pine.LNX.4.21.0012292156200.11714-200000@winds.org>
Message-ID: <Pine.LNX.4.10.10012292112460.2009-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, I don't think this is an athlon bug, and I think I've figured out what
the problem is.  For now, you rtemporary fix is probably fine, I'll clean
stuff up a bit and make a nicer patch available tomorrow.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
