Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSGGS1S>; Sun, 7 Jul 2002 14:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316355AbSGGS1R>; Sun, 7 Jul 2002 14:27:17 -0400
Received: from THANK.THUNK.ORG ([216.175.175.163]:7552 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S316342AbSGGS1R>;
	Sun, 7 Jul 2002 14:27:17 -0400
Date: Sat, 6 Jul 2002 08:45:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Rob Landley <landley@trommello.org>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@fs.tum.de>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
Message-ID: <20020706124534.GA476@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Russell King <rmk@arm.linux.org.uk>,
	Rob Landley <landley@trommello.org>,
	Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@fs.tum.de>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020702110848.27954D-100000@gatekeeper.tmr.com> <200207030718.g637I0L145202@pimout2-int.prodigy.net> <20020704131654.B11601@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020704131654.B11601@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 01:16:54PM +0100, Russell King wrote:
> On Tue, Jul 02, 2002 at 09:19:41PM -0400, Rob Landley wrote:
> > Look at the pressure to get stuff into 2.4 when it's already in 2.5.  Because 
> > 2.4 is what people are actually using, and 2.5 is really just for os 
> > development and testing (and general playing with) at this point.
> 
> If stuff in 2.5 wasn't soo broken (looking at IDE here) then more people
> would be using it, and less people would be wanting the 2.5 features back
> ported to 2.4.  IMHO, at the moment 2.5 has a major problem.  It is not
> getting the testing it deserves because things like IDE and such like
> aren't reasonably stable enough.

And the obvious answer to this is a backport of the 2.4 IDE subsystem
to 2.5.....  CONFIG_IDE_WONT_FIND_NEW_E2FSCK_BUGS, anyone?  :-)

						- Ted
