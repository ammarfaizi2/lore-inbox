Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbREQHYv>; Thu, 17 May 2001 03:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbREQHYl>; Thu, 17 May 2001 03:24:41 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:20740 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261289AbREQHYe>;
	Thu, 17 May 2001 03:24:34 -0400
Date: Tue, 15 May 2001 17:01:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010515170119.A81@toy.ucw.cz>
In-Reply-To: <20010514213516.A15744@work.bitmover.com> <Pine.GSO.4.21.0105150039560.19333-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0105150039560.19333-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, May 15, 2001 at 12:59:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Besides, just how often do you reboot the box? If that's the hotspot for
> you - when the hell does the boor beast find time to do something useful?

Ten times a day?

But booting is special case: You can read your mail while compiling kernel, 
but try to read your mail while your machine is booting.

What's worse, boot time tends to be time critical, as in "I need to find that 
mail that tells me where I'm expected to be half an hour from now. Ouch. It's 
going to take 40 minutes to get there."
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

