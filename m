Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282509AbRKZUi4>; Mon, 26 Nov 2001 15:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282504AbRKZUik>; Mon, 26 Nov 2001 15:38:40 -0500
Received: from h24-80-72-10.vn.shawcable.net ([24.80.72.10]:23569 "EHLO
	linisoft.localdomain") by vger.kernel.org with ESMTP
	id <S282490AbRKZUhm>; Mon, 26 Nov 2001 15:37:42 -0500
Message-ID: <3C02A85D.99C63F00@linisoft.com>
Date: Mon, 26 Nov 2001 12:38:53 -0800
From: Reza Roboubi <reza@linisoft.com>
Organization: Linisoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: testing and related tools: your opinions please
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not work on the kernel (yet), but have read much of the fight
regarding "kdb availability."  Personally, I've found the Linux Kernel
Coding Style and the tips and views Linus Torvalds provided on debugging
_extremely_ useful and _practical_ in my own work.

Your opinions on any of the following will be greatly appreciated:
-----------------------------------------
What do you think of testing and related tools like gcov (that measure
which code branches are executed and the like?)

Generally, how do you maintain such level of reliability on such a huge
monolithic kernel (except  by "thinking it through?")

After unit testing, does the Linux kernel rely mainly on _actual_runs_
by users/developers for testing the reliability of the whole thing?

Do you have test scripts and automated regression testing setup, or you
and Linus do not believe in that either?

Linus,  if you are reading, (how) did you test the original 200K kernel
code when you were still working mostly _by_yourself_?  How much did
others help with the bugs you might have left? (if any!)

Boundary conditions?  How do you test them?

If anybody knows what Linus or Alan Cox might think of all this, then
please tell me too.  I am interested in their opinion but they might not
respond  to the message.

If relevant, please also tell me what work you do on the kernel.

I greatly appreciate your time and any insight you provide.


--
Reza Roboubi
Software Development Consultant
www.linisoft.com



