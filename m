Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129913AbQLVSOO>; Fri, 22 Dec 2000 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130319AbQLVSOE>; Fri, 22 Dec 2000 13:14:04 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:10263 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129913AbQLVSNy>; Fri, 22 Dec 2000 13:13:54 -0500
Date: Fri, 22 Dec 2000 19:50:40 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Pavel Machek <pavel@suse.cz>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <200012211927.eBLJROd347633@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.21.0012221949000.15294-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Doing it this way is _way_ better for system
> > stability, because kidle-apmd sometimes dies due to APM
> > bug. kidle-apmd dying is recoverable error; swapper dieing is as fatal
> > as it can be.
> 
> Good. Maybe the bugs will get fixed then. If the bugs are in
> the BIOS or motherboard hardware, we can have a blacklist.

If the're a lot of buggy APM BIOS'es out there it may indeed not be a wise
idea to throw everything on one pile.


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
