Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135634AbRD2MfX>; Sun, 29 Apr 2001 08:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135760AbRD2MfO>; Sun, 29 Apr 2001 08:35:14 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:37124 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S135634AbRD2MfA>; Sun, 29 Apr 2001 08:35:00 -0400
From: Colonel <klink@clouddancer.com>
To: linux-kernel@vger.kernel.org
Subject: OOM stupidity
Reply-To: klink@clouddancer.com
Message-Id: <20010429123454.364E06808@mail.clouddancer.com>
Date: Sun, 29 Apr 2001 05:34:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When the OOM kills the process that I am currently composing within
(an active character stream), that is a MICROSOFT WINDOWS behavior.  
I don't care if it's hogging the machine, *I'M* using it!  That is the
point after all, isn't it?  A human sysadmin could kill my process
(and then I would have dealings with him), but the logic here is badly
flawed.

If this is what Linux will become in the 2.4 kernel, *FORGET IT*.
Swap was hardly filled up, and remember it's the 2xRAM swap size now!
Has Linux been too eager to accept recent windows converts (and prior
to their recovery from that brain damage) and lost it's sharp edge of
careful thought and tooling that was it's hallmark in the beginning??
Are the maintainers of this area too busy "protecting their turf" to
allow some options to the end user?  Seem like Linus better kick some
butt before it's too late.  Microsoft has been running a
disinformation campaign against Linux for awhile, but the current OOM
behavior could allow them to make a major capitalization against
Linux.

Just think of the Microsoft campaign :
"We don't pull the rug out from underneath you".

(Note to all those that will jump up and claim that Microsoft has
problems -- I see, you are saying because MS is faulty, it's OK that
Linux is faulty)

Where is a patch to allow the sensible OOM I had in prior kernels?
(cause this crap is getting pitched)

--------

(kernel 2.4.4-pre6, not noticed in eariler kernels, but machine was
not that heavily used.  Hardware has been rock solid for years.  Load
at the time was trivial compared to 2.0 series kernels workload.)

____
ron

- I don't need no stinkin multiline sig -
