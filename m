Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRCHVPS>; Thu, 8 Mar 2001 16:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbRCHVPI>; Thu, 8 Mar 2001 16:15:08 -0500
Received: from mail.inf.elte.hu ([157.181.161.6]:31894 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S129725AbRCHVPA>;
	Thu, 8 Mar 2001 16:15:00 -0500
Date: Thu, 8 Mar 2001 22:14:25 +0100 (CET)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [QUESTION] mga memsize
Message-ID: <Pine.A41.4.31.0103082205090.141016-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

How can I check the memsize of a matrox g400?
I have a card with 16Mb memory, and the lspci show this:
        Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SDRAM
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at e6000000 (32-bit, prefetchable) [size=32M]

So I could use the 16Mb in the name of the card, but an older lspci
doesn't show that.
In the 3rd line, it reports 32M. It doesn't work.
the matroxfb init reports the correct memsize, but I don't know, how to
get that.

Any idea?

Bye,
Szabi


