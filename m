Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129539AbQLCDc7>; Sat, 2 Dec 2000 22:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbQLCDct>; Sat, 2 Dec 2000 22:32:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57099 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129539AbQLCDcj>; Sat, 2 Dec 2000 22:32:39 -0500
Date: Sat, 2 Dec 2000 19:01:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Transmeta and Linux-2.4.0-test12-pre3 [slightly off-topic]
In-Reply-To: <200012020955.eB29tpK03869@moisil.dev.hydraweb.com>
Message-ID: <Pine.LNX.4.10.10012021900440.7191-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Dec 2000, Ion Badulescu wrote:
> 
> If it's the same bug that locks up the ATI chipset on my Dell laptop,
> then you can safely enable DPMS if only enable the standby mode,
> not the others (suspend and off). The panel gets turned off anyway,
> even in standby.

Yup, same bug, and yes, "dpms standby" works, only suspend and off are
broken.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
