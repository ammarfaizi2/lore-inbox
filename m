Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWGJRcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWGJRcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbWGJRcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:32:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422725AbWGJRcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:32:04 -0400
Date: Mon, 10 Jul 2006 10:11:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Automatic Kernel Bug Report
Message-ID: <20060710081131.GA2251@elf.ucw.cz>
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com> <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com> <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com> <20060709125805.GF13938@stusta.de> <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com> <20060709191107.GN13938@stusta.de> <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com> <200607092019.k69KJt66005527@turing-police.cc.vt.edu> <e1e1d5f40607091327y3db1cbdco89ebdb04cda60ce0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40607091327y3db1cbdco89ebdb04cda60ce0@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Sometimes the user may be just somebody that just started using linux,
> >> or is in an industry that has nothing related to computers. He doesn't
> >> even know that syslog exists, and even if he did, he could not even
> >> care about it.
> >
> >This user will do whatever his distro tells him to do, which is almost
> >certainly something *other* than what a kernel.org kernel should do.
> >If he's running Ubuntu, it should do whatever Ubuntu does.  If he's
> >on Fedora Core, it should poke the RedHat bugzilla, and so on.
> >
> >If he's running a kernel.org kernel, it's probably safe to assume *some*
> >level of clue
> >
> 
> This was actually just an example circunstance of why somebody would
> not report a bug. Dozens of other circunstances may be given, and it
> just illustrates why would be good to have those bug reports without
> user interaction. Of course I can go to bugzilla and fill a report
> upon a bug, but I wouldn't care to have bug reports being sent from my
> servers automatically, if it's an option. This would ensure that even
> bug report from non-caring users are, well, reported.

Well, unless we have some volunteer to go through the bugreports and
sort them/kill the invalid ones/etc... this is going to do more harm
than good.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
