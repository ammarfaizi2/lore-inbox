Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130513AbRBKAtW>; Sat, 10 Feb 2001 19:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131377AbRBKAtM>; Sat, 10 Feb 2001 19:49:12 -0500
Received: from pikachu.3ti.org ([212.204.216.221]:44293 "EHLO pikachu.3ti.org")
	by vger.kernel.org with ESMTP id <S130513AbRBKAtD>;
	Sat, 10 Feb 2001 19:49:03 -0500
Date: Sun, 11 Feb 2001 01:49:01 +0100 (CET)
From: Dag Wieers <dag@mind.be>
X-X-Sender: <dag@pikachu.3ti.org>
To: <linux-kernel@vger.kernel.org>
cc: "Richard E. Gooch" <rgooch@atnf.csiro.au>
Subject: Re: Unresolved symbols for wavelan_cs in 2.4.1-ac9
Message-ID: <Pine.LNX.4.32.0102110144560.11777-100000@pikachu.3ti.org>
User-Agent: Mutt/1.2i
X-Mailer: Evolution 1.0 (Stable release)
Organization: Mind Linux Solutions in Leuven/Belgium - http://mind.be/
X-Extra: If you can read this and Linux is your thing. Work for us !
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Rik van Riel wrote:

>> Rejected. It is meant not to be there.
>
> To be more specific ... __bad_udelay() is meant to be an
> unresolvable symbol, which is referenced when people call
> udelay with a "wrong" timeout.

Maybe this (and similar situations) could be added to the lkml-FAQ ?
It would have prevented me to post it on lkml ;)

Thanks,

--  dag wieers, <dag@mind.be>, http://mind.be/  --
            Out of swap, out of luck.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
