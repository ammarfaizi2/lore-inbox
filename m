Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157615AbQGaPJ1>; Mon, 31 Jul 2000 11:09:27 -0400
Received: by vger.rutgers.edu id <S157541AbQGaPHc>; Mon, 31 Jul 2000 11:07:32 -0400
Received: from ci176196-a.grnvle1.sc.home.com ([24.4.120.228]:1051 "EHLO rhino.thrillseeker.net") by vger.rutgers.edu with ESMTP id <S157531AbQGaPGM>; Mon, 31 Jul 2000 11:06:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14725.39563.946561.142225@rhino.thrillseeker.net>
Date: Mon, 31 Jul 2000 11:26:03 -0400 (EDT)
From: Billy Harvey <Billy.Harvey@RhinoComputing.com>
To: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Cc: Linux Kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
In-Reply-To: <39859644.340AE15E@baldauf.org>
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org> <39858A9F.C272E4E8@baldauf.org> <20000731163127.G2224@lxMA.mediaways.net> <3985919F.3ADB81AD@baldauf.org> <20000731165300.I2224@lxMA.mediaways.net> <39859644.340AE15E@baldauf.org>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: owner-linux-kernel@vger.rutgers.edu

Xuan Baldauf writes:
...
 > But I never wanted it to be in sleep (rather than standby) mode, my original
 > intent was to bring the system to a state where spin ups are only done when
 > necessary. Someone said something about noflushd, but I could not find any links
 > or rpm packages, does anybody have...?

http://www.tuebingen.linux.de/~s-kod1/noflushd/testing/ .  I'm testing
the latest version right now on my Toshiba notebook, and it seems to
work fine.

Billy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
