Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130868AbRAEHRV>; Fri, 5 Jan 2001 02:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130895AbRAEHRL>; Fri, 5 Jan 2001 02:17:11 -0500
Received: from 209.102.21.2 ([209.102.21.2]:45583 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S130868AbRAEHRA>;
	Fri, 5 Jan 2001 02:17:00 -0500
Message-ID: <3A55447D.995FB159@goingware.com>
Date: Fri, 05 Jan 2001 03:50:21 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-prerelease-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might find it interesting to read the section entitled "Monkeywrenching the
Virtual Machine" towards the end of "Why We Should All Test the New Linux
Kernel".  It's in my second comment after the main article:

http://advogato.org/article/224.html

I understand Linus' desire to have more widespread testing done on the kernel,
and certainly he can accomplish that by labeling some random build as the new
stable version.  But I think a better choice would have been to advocate testing
more widely - don't just announce it to the linux-kernel list, get on National
Public Radio, the Linux Journal and Slashdot and stuff.  

Don't just announce the existence of a kernel that people ought to test, but hit
the streets and provide advice and assistance and encouragement to those who
might help out.

That's the kind of thing I was trying to do in my article above.

My concern is that declaring this kernel as production and stable, with patching
still happening by the minute, is that a lot of people who don't know what
they're doing will slap it into machines they depend on for their livelihood,
and a lot of distributions will quickly adopt it in order to be perceived as
competitive.  The very first experience many people will ever have with Free
Software will boot off Linux 2.4.0 - not 2.4.1, because some distro will want to
be the first.

You might think this is great because of all the extra testing the new users
will do but I assert that it isn't.  The environment for Linux is quite
different these days than when 2.2 or 2.0 were released.

A lot of the people who will be using it are not technically savvy people, and
many of those who do know technology depend on its reliability for the
profitability of large businesses but may not read Linus' message that indicates
this is really just for testing.

It would be really bad if this particular version of the kernel turns out to
have a lot of problems.

I guess you can get more people testing by releasing it yourselves than I can
with my websites saying people should test, but I feel that having the testing
done by people who know what they're getting into and have some guidance is a
wiser course of action.

If you're in the neighborhood, please stop by:

http://linuxquality.sunsite.dk

Mike


-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
