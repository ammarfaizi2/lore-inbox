Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSGDMOZ>; Thu, 4 Jul 2002 08:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317397AbSGDMOY>; Thu, 4 Jul 2002 08:14:24 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:38157 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317396AbSGDMOY>; Thu, 4 Jul 2002 08:14:24 -0400
Date: Thu, 4 Jul 2002 13:16:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rob Landley <landley@trommello.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@fs.tum.de>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
Message-ID: <20020704131654.B11601@flint.arm.linux.org.uk>
References: <Pine.LNX.3.96.1020702110848.27954D-100000@gatekeeper.tmr.com> <200207030718.g637I0L145202@pimout2-int.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207030718.g637I0L145202@pimout2-int.prodigy.net>; from landley@trommello.org on Tue, Jul 02, 2002 at 09:19:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 09:19:41PM -0400, Rob Landley wrote:
> Look at the pressure to get stuff into 2.4 when it's already in 2.5.  Because 
> 2.4 is what people are actually using, and 2.5 is really just for os 
> development and testing (and general playing with) at this point.

If stuff in 2.5 wasn't soo broken (looking at IDE here) then more people
would be using it, and less people would be wanting the 2.5 features back
ported to 2.4.  IMHO, at the moment 2.5 has a major problem.  It is not
getting the testing it deserves because things like IDE and such like
aren't reasonably stable enough.

Some developers in the ARM community have been to use 2.4 because 2.5
IDE has been broken for soo long.  Having initially based their
development on 2.5, then being forced to switch to 2.4, they're not
going to switch back to 2.5 unless there's a _really_ good reason to.
Fixing IDE isn't "a really good reason" as far as they are concerned.

If we're going to make the 2.5 freeze in October and IDE remains as
unstable as it has since 2.5.4-ish, the months^wyears after that are
going to be a rough ride, and it will take a long time to shake the
bugs out.

At OLS, I was suggesting to people that 2.6 might happen in the summer of
2003.  I'm seriously considering moving that estimate to Christmas 2003
or first couple of months of 2004 now.

Feel free to prove me wrong in one and a half years time. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

