Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKDU0n>; Sat, 4 Nov 2000 15:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129262AbQKDU0d>; Sat, 4 Nov 2000 15:26:33 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:39694 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129103AbQKDU0Z>; Sat, 4 Nov 2000 15:26:25 -0500
Date: Sat, 4 Nov 2000 14:26:20 -0600
To: Taco Witte <mail@tcwitte.myweb.nl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: modular kernel
Message-ID: <20001104142620.N1041@wire.cadcamlab.org>
In-Reply-To: <m13s4Pi-000leyC@green.nl.gxn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m13s4Pi-000leyC@green.nl.gxn.net>; from mail@tcwitte.myweb.nl on Sat, Nov 04, 2000 at 03:38:15PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[yes I feed trolls sometimes, it's fun]

[Taco Witte]
> Some days ago, I read about the idea of a completely modular kernel.
> I think it's a very good idea, because it would make it easier to get
> more people work at the same moment, development would go faster.

I contend that the barrier to entry is already quite low, as proven by
the fact that *I* contribute to kernel development, albeit rather
little.  What evidence do you have to the contrary?


> It would be possible to make groups for a certain part of the kernel
> (for example sound, or filesystems, or main) with own group pages
> with status info and todo's and own mailinglists (it would divide
> this enourmous flow of mail into smaller parts).

Run the following command in the Linux source directory:

  grep '^[LW]:' MAINTAINERS | sort -u | more

Then come back with your hot new ideas about having different mailing
lists and web pages for each subsystem.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
