Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbRAOC6I>; Sun, 14 Jan 2001 21:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbRAOC56>; Sun, 14 Jan 2001 21:57:58 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:40948 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S131341AbRAOC5m>; Sun, 14 Jan 2001 21:57:42 -0500
Date: Sun, 14 Jan 2001 18:56:30 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
cc: "V.P." <vpedro@individual.EUnet.pt>, linux-kernel@vger.kernel.org
Subject: Re: APIC ERRor on CPU0: 00(02) ...
In-Reply-To: <20010113122050.A1300@grobbebol.xs4all.nl>
Message-ID: <Pine.LNX.4.21.0101141849280.32248-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001, Roeland Th. Jansen wrote:

> you can say about the BP6 what you want but it appears that there are
> (if your vision is right) many other low end SMP boards categorized
> trash. there has been one mistake with it and that's the capacitor
> behind a regulator that may have been mis-dimentioned due to the
> partchange of that particular capacitor.

::nods:: Yes, I realize that there are other low-end SMP boards
categorized trash, but when someone asks me what low-end SMP motherboard
to get, the first thing I tell them is to /not/ get the BP6.

> my 2.2 kernel running on the BP6 proves that it may work very well,
> unless you think that uptimes of > 40 days is bad.

If you think that a stream of APIC retries is 'working very well,' then
I'm sorry to say, you've got another thing coming. :p Besides, a 40 day
uptime is *not* all that spectacular; I've had uptimes in excess of 200
days before, running on garbage hardware (worse than even the BP6).

anyways, the fact remains that it was your motherboard that is causing
these errors. The retries are still there in 2.2, they just aren't
reported.

ciau
-Kelsey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
