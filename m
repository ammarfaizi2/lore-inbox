Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSE2NyI>; Wed, 29 May 2002 09:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSE2NyH>; Wed, 29 May 2002 09:54:07 -0400
Received: from sprocket.loran.com ([209.167.240.9]:60401 "EHLO
	ottonexc1.peregrine.com") by vger.kernel.org with ESMTP
	id <S315279AbSE2NyF>; Wed, 29 May 2002 09:54:05 -0400
Subject: Re: A reply on the RTLinux discussion.
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020528213457.A22540@mark.mielke.cc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 May 2002 09:54:06 -0400
Message-Id: <1022680446.9043.5.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 21:34, Mark Mielke wrote:
> It is really simple. Either A) Victor has a patent, and code in RTAI
> may need to be licensed, or B) Victor has a patent, and code in RTAI
> does not need to be licensed.

I think this is the main, critical, horrendous point.

RTAI is free, open source software.
whether it is covered by the licence or not, it's allowed by the
free clauses in rtlinux.

The problem here (and i can see why Karim is upset) is that people
who use RTAI to make commercial, closed source software may ALSO be
required to licence RTLinux even though they're using RTAI, not
RTLinux.

This would be retarded.  I mean, seriously, making the linux kernel
require anybody who's doing any commercial real-time stuff pay Victor
because it's in the kernel source and it's patented is just plain dumb.
Linus doesn't want to force anyone to use bitkeeper, why should he force
anyone to pay Victor as well?

Of course I must point out that it's easy for me to speak up : although
I do almost entirely embedded work I have absolutely no use for RT
software here, so I'm not affected at all.  I just see it as a slippery
slope towards BSD :)

Dana Lacoste
Ottawa, Canada

