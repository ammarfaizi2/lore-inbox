Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130092AbQLSMgJ>; Tue, 19 Dec 2000 07:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130120AbQLSMf7>; Tue, 19 Dec 2000 07:35:59 -0500
Received: from 209.102.21.2 ([209.102.21.2]:52751 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S130092AbQLSMfr>;
	Tue, 19 Dec 2000 07:35:47 -0500
Message-ID: <3A3F1E6A.AAEC9F5F@goingware.com>
Date: Tue, 19 Dec 2000 08:38:02 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux Quality Database Project
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last may I posted a message to the list with the subject "Organized
Linux QA?" asking if there'd be any interest
in building a web database to collect bug reports in linux kernel test
versions and to make it easier to search for
bugs (and success reports) based on things like hardware configuration
and kernel configuration (the database would parse .config files and you
could search by the options in it).

My original message is archived at:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0005.3/1437.html

and was posted Wed, May 31 2000.  You can read the brief thread that
ensued from the archives.

I felt the process of reporting a bug to the linux-kernel list and
staying on the list to ensure the bug got fixed and stayed fix was
likely to be intimidating to a lot of the people who might otherwise be
helpful to you in reporting bugs.
I thought a web application like this would encourage more users to
participate, basically you'd need to know enough to apply a patch, build
a kernel from source and log the results into a web form.

Things got kind of nuts in my consulting business for a while (I also
got married, on July 22, to a woman from Newfoundland - I'm from
California) and I couldn't deal with this for a while.  But my life is
settling down a bit and I'd like to take this back up.

So far the project has nothing but a home page saying what it's about,
but it's hosted at SunSITE Denmark
(http://sunsite.dk), which has a powerful server and provides a lot of
services to the open source community:

http://linuxquality.sunsite.dk

If you'd like to participate or know someone who would there's
instructions on subscribing to the database developer's mailing list on
the page (send an empty message to linuxquality-dev-subscribe@sunsite.dk
)

Of course, the sort of programming one usually does for a
database-backed web application is typically different than kernel
programming so I don't expect many of you will want to help write the
thing.  But I would appreciate having some of you participate in the
design so that we can ensure the result will serve your needs, and
passing this message on to web applications programmers who you think
might want to participate.

I want to say right off that it is not my objective to impose some kind
of corporate quality process on the Linux kernel developers.  That would
be pretty presumptuous of me as I've never been a kernel developer, let
alone any kind of leader in the Linux community.  So there will be
explicitly no requirement that any developer participate at all to work
with the bug database - I'm not suggesting you all should start tracking
your open bugs on my database or closing them when they're fixed or
referring them back to testers as is the usual practice in big company
software projects.

I do want to provide configurable levels of participation, ranging from
a request that submitted bugs in a particular component just be
forwarded to the linux-kernel list, to mailing problem summaries to a
developer who would then browse the database, to the possibility of
interacting regularly with the database.

It would be fine if the database served as a passive repository of bug
info that you could browse at your leisure.

(I'm not subscribed to the linux-kernel list, but will be reading it off
an archive.  Subscribing last spring filled my inbox so full that it
overflowed /tmp on my hosting service when I ran elm).

Regards,

Michael D. Crawford
GoingWare Inc. -Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
