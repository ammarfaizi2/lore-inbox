Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRAJMtP>; Wed, 10 Jan 2001 07:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135506AbRAJMtF>; Wed, 10 Jan 2001 07:49:05 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:34065 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S135276AbRAJMs5>; Wed, 10 Jan 2001 07:48:57 -0500
Date: Wed, 10 Jan 2001 14:55:59 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <UTC200101092343.AAA149309.aeb@texel.cwi.nl>
Message-ID: <Pine.LNX.4.21.0101101454180.13938-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Probably you confused the proper way to use ibmsetmax with
> the proper way to use setmax. For setmax, and a Maxtor disk,
> you do not use a different machine, put the jumper to clip,
> now the boot succeeds, and you let Linux unclip.
> Either with a patched kernel that knows about these things
> or with a utility run from a boot script.
> (It is most convenient to have a partition boundary where
> the jumper clips, so that with old kernels and without running
> the utility you also have a valid filesystem.)

I found out yesterday after searching the mailinglist... My bad.
Thanx for the info.

2.2.18 + ide is patched, 2.4.0 isn't. 


	Regards,

		Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
