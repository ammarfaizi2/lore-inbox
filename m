Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136177AbRAJVwc>; Wed, 10 Jan 2001 16:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136800AbRAJVwW>; Wed, 10 Jan 2001 16:52:22 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:44554 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S136177AbRAJVwT>;
	Wed, 10 Jan 2001 16:52:19 -0500
Date: Wed, 10 Jan 2001 22:52:46 +0100 (CET)
From: <kernel@ddx.a2000.nu>
To: "David S. Miller" <davem@redhat.com>
cc: <hacksaw@hacksaw.org>, <linux-kernel@vger.kernel.org>
Subject: Re: unexplained high load
In-Reply-To: <200101102139.NAA07105@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101102249390.4377-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, David S. Miller wrote:

>    Date: 	Wed, 10 Jan 2001 16:36:14 -0500
>    From: Hacksaw <hacksaw@hacksaw.org>
>
>    You'll have to reboot to clear it. I believe this is a kernel
>    bug. Try going back to 2.2.14, or maybe up to 2.2.19pre2.
>
> He needs to go up if anything.  His sparc64 OOPS had strings in the
> kernel stack, which is indicative of a sparc64 specific bug I only
> fixed very late in the 2.2.18 patches.
don't think i want 2.2.14 (which had some security bugs i remember)
so i should move up i think
before i go download and compile the latest 2.2.19pre7 (latest pre
version)
and reboot:

are there any bugs at the moment for sparc64 ?
and should i wait for the finale 2.2.19 ?
(don't think i can go download and use 2.4.0 since machine is still based
on redhat 6.1)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
