Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRATPdS>; Sat, 20 Jan 2001 10:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRATPdI>; Sat, 20 Jan 2001 10:33:08 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:21247 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129729AbRATPdE>; Sat, 20 Jan 2001 10:33:04 -0500
Message-Id: <5.0.2.1.2.20010120152158.00ab7bc0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sat, 20 Jan 2001 15:32:51 +0000
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Coding Style
Cc: Mark I Manning IV <mark4@purplecoder.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10101192217390.9361-100000@penguin.transmeta
 .com>
In-Reply-To: <3A68E309.2540A5E1@purplecoder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:29 20/01/2001, Linus Torvalds wrote:
>On Fri, 19 Jan 2001, Mark I Manning IV wrote:
[snip]
> > > And two spaces is not enough. If you write code that needs comments at
> > > the end of a line, your code is crap.
> >
> > Might i ask you to qualify that statement ?
>
>Ok. I'll qualify it. Add a "unless you write in assembly language" to the
>end. I have to admit that most assembly languages are terse and hard to
>read enough that you often want to comment at the end. In assembly you
>just don't tend to have enough flexibility to make the code readable, so
>you must live with unreadable code that is commented.

Would you not also add "unless you are defining structure definitions and 
want to explain what each of the struct members means"?

[snip]
>Notice? Not AFTER the statements.
>
>Why? Because you are likely to want to change the statements. You don't
>want to keep moving the comments around to line them up. And trying to
>have a multi-line comment with code is just HORRIBLE:

And structs are not likely to change so this argument would not longer apply?

Just curious.

Regards,

         Anton


-- 
    "Programmers never die. They do a GOSUB without RETURN." - Unknown source
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
