Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277135AbRJ0VWm>; Sat, 27 Oct 2001 17:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277144AbRJ0VWc>; Sat, 27 Oct 2001 17:22:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10950 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277135AbRJ0VWR>;
	Sat, 27 Oct 2001 17:22:17 -0400
Date: Sat, 27 Oct 2001 17:22:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <E15xaiJ-0001Na-00@localhost>
Message-ID: <Pine.GSO.4.21.0110271712520.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Oct 2001, Ryan Cumming wrote:

> It might be more productive to provide patches or at least generate 
> constructive ideas as how to fix these problems, as you are obviously quite 
> capable of doing so. Digging through the code and sending a new email to this 
> list for every few flaws you find is doing little good, and your personal 
> attacks on the maintainer are even less benefical. Cooperation will get you a 
> lot farther than conflict.

Been there, tried that, had been told by Richard that he would rather fix
devfs bugs himself.  Quite a few months ago.  If you have better suggestions
they would be more than welcome.

As far as I can see, if maintainer doesn't fix the bugs himself and tells
that patches are not welcome there are only two things that can be done -
going into full-disclosure mode in hope that it will change the situation or
taking over the code in question.

By that point I'm sorely tempted to do the latter (i.e. full-blown fork,
maintained with no regard to Richard's preferences + sumbitting [very
massive] fixes directly to Linus), but I want to give a try to less
drastic approach first.

