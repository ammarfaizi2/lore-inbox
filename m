Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBDRtY>; Sun, 4 Feb 2001 12:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132138AbRBDRtO>; Sun, 4 Feb 2001 12:49:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19218 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129272AbRBDRs5>; Sun, 4 Feb 2001 12:48:57 -0500
Date: Sun, 4 Feb 2001 09:48:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre1
In-Reply-To: <Pine.LNX.4.30.0102032118020.13720-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.10.10102040944440.2777-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Linux-kernel added to the cc, as others probably also wonder ]

On Sat, 3 Feb 2001, David D.W. Downey wrote:
>
> 	How often does Alan's patches get rolled into your main line? I'm
> having difficulty following the divergence here. I'm trying to run THE
> latest release(s) of your kernel with applicaple patches. I'm just trying
> to figure out if everything that is in the ac## line is ALWAYS rolled into
> your pre## line or not. Which patch sequence am I supposed to follow to
> have THE most current release of all fixes et. al.?

Alan tends to have much more experimental patches than I do - and we don't
sync up more often than maybe once a month or so. And even then, the
sync-up won't be complete, exactly because I don't take the experimental
parts (or more accurately, Alan mostly doesn't even try to send them to me
and we tend to agree pretty well on what is appropriate and what is not).

We're nearing another sync-point right now - I actually have a lot of
Alans patches in my mail-box, and -pre2 will probably contain a lot of the
-ac stuff. But don't expect a complete sync, as explained above.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
