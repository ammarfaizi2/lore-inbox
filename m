Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129536AbQJ0Ul3>; Fri, 27 Oct 2000 16:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbQJ0UlT>; Fri, 27 Oct 2000 16:41:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44037 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129536AbQJ0UlK>;
	Fri, 27 Oct 2000 16:41:10 -0400
Message-ID: <39F9E849.D799D4A5@mandrakesoft.com>
Date: Fri, 27 Oct 2000 16:40:41 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
In-Reply-To: <39F5830E.7963A935@uow.edu.au> <Pine.LNX.4.10.10010241353590.1743-100000@penguin.transmeta.com> <20001027194513.A1060@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Would it be possible to keep 2.7.2.3? You still need 2.7.2.3 to
> reliably compile 2.0.X (and maybe even 2.2.all-but-latest?).

What fails, when you use egcs-1.1.2 to build 2.0.x or early 2.2.x?

Maybe they need -fno-strict-aliasing... is that what you are referring
to?

Regards,

	Jeff



-- 
Jeff Garzik                    | "Mind if I drive?"  -Sam
Building 1024                  | "Not if you don't mind me clawing at
the
MandrakeSoft                   |  dash and screaming like a
cheerleader."
                               |      -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
