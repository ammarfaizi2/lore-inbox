Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131965AbRAMSfl>; Sat, 13 Jan 2001 13:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAMSf0>; Sat, 13 Jan 2001 13:35:26 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130754AbRAMSYs>;
	Sat, 13 Jan 2001 13:24:48 -0500
Date: Sat, 13 Jan 2001 09:04:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.30.0101131639500.21182-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10101130903580.1959-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jan 2001, David Woodhouse wrote:
> 
> Please can we also stop HPT366 from attempting UDMA66 on the IBM DTLA
> drives, while we're at it? I don't care if it's done by blacklisting the
> DTLA drives, as was done by the patch I resent numerous times, or if it's
> done the other way round by putting known-compatible drives (include
> "FUJITSU MPE3136AT") into a whitelist. But it needs doing.

Somebody who can test it needs to send me a patch - I'm NOT going to apply
patches that haven't been tested and that I cannot test myself.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
