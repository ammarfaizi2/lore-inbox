Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278808AbRKOFWx>; Thu, 15 Nov 2001 00:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280737AbRKOFWo>; Thu, 15 Nov 2001 00:22:44 -0500
Received: from epithumia.math.uh.edu ([129.7.128.2]:45698 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id <S278808AbRKOFW3>; Thu, 15 Nov 2001 00:22:29 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <Pine.GSO.4.33.0111141421230.14971-100000@gurney>
	<3BF31C42.469BF2B2@randomlogic.com>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: 14 Nov 2001 23:22:24 -0600
In-Reply-To: "Paul G. Allen"'s message of "Wed, 14 Nov 2001 17:37:06 -0800"
Message-ID: <ufawv0sr4kv.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "PGA" == Paul G Allen <pgallen@randomlogic.com> writes:

PGA> I have a Tyan K7 Thunder with dual 1.4GHz Thunderbirds. It took
PGA> me a week to get it working, and was the initial reason I joined
PGA> this list.

Perhaps the Thunder boards are more difficult, because I just bought a
Tiger board, slapped 2 1.4GHz Athlons in it, filled it up with 3GB of
RAM and tossed in an extra 256MB DIMM just to see if it would work
[1], installed Red Hat 7.1 (running 2.4.3, not the most recent
erratum) and proceeded to run two different large-memory numerical
codes (one cache-heavy uniform-stride with heavy prefetch usage and
one with a completely nonuniform access pattern) and repeated kernel
compiles concurrently for a solid week and had no problems.  Then I
upgraded to 1800+ XP processors and repeated things and it all just
works, even though it's got more than the officially supported 3GB and
isn't using officially supported MP processors.

I'm not running high-performance graphics or the like, however, so AGP
obviously isn't getting heavily tested.  It is running X on a G400,
however, and that's working well enough.

1) Actually I did have a problem getting good memory.  1GB DIMMs seem
   somewhat tough to come by and my supplier only has them from Smart
   Modular Technologies.  Fully three out of six sticks we got in were
   bad.  Not just in the Tiger MP board but also in an Abit KG7.  The
   Tiger board may be finicky about memory, but this Smart Modular
   stuff just seems bad.  (It is on Tyan's "approved list", however.)

 - J<
