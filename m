Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282291AbRKWXgF>; Fri, 23 Nov 2001 18:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282287AbRKWXfz>; Fri, 23 Nov 2001 18:35:55 -0500
Received: from [212.18.232.186] ([212.18.232.186]:51461 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282288AbRKWXfl>; Fri, 23 Nov 2001 18:35:41 -0500
Date: Fri, 23 Nov 2001 23:35:02 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][CFT] Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011123233502.C3141@flint.arm.linux.org.uk>
In-Reply-To: <Pine.GSO.4.21.0111231634310.2422-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0111231701440.2422-100000@weyl.math.psu.edu> <20011123160536.D1308@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011123160536.D1308@lynx.no>; from adilger@turbolabs.com on Fri, Nov 23, 2001 at 04:05:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 04:05:36PM -0700, Andreas Dilger wrote:
> Hey, this gives Linus a good reason to make another 2.4.15 release,
> and silence all of the people complaining about -greased-turkey (which,
> as we all know, was Linus' prerelease for testing that everything was
> working OK before he made an _official_ 2.4.15 release, and a good thing
> he did or this bug wouldn't have shown up until the _official_ 2.4.15
> release which would have been embarassing ;-).

Actually, had Linus have waited until tonight before doing the 2.4.15
release, I would've been running 2.4.15-pre9 on the machine which showed
the problem.

>From pre7, pre8 came out, didn't even get to build that before pre9 came
out.  Built pre9, slept.  Woke up and 2.4.15-dead-duck was out.  Had I
not immediately grabbed the dead-duck release, I would've been running
pre9 on the machine, which I understand contains the problem as well.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

