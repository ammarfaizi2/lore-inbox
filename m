Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTJNLpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTJNLpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:45:16 -0400
Received: from smtp1.libero.it ([193.70.192.51]:31677 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S262440AbTJNLpF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:45:05 -0400
Date: Tue, 14 Oct 2003 13:44:31 +0200
Message-Id: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it>
Subject: Unbloating the kernel, was: :mem=16MB laptop testing
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "Marco Fioretti" <m.fioretti@inwind.it>
To: "wli" <wli@holomorphy.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B13)
X-type: 0
X-SenderIP: 194.237.142.24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I tried mem=16m on my laptop (stinkpad T21). I made the following
> potentially useless observations:
[snip]
> I guess the upshot is "unbloating" the kernel wouldn't do much good
> anyway, since luserspace isn't in any kind of shape to run in this kind
> of environment anymore either.

Wrong. (please read till the end, this is not academic, but a real call to arms!)

Have a look at http://www.rule-project.org/en/, specifically the pages:

http://www.rule-project.org/en/sw/kdrive.php (how we do without X, solving half
of the problem)

http://www.rule-project.org/en/test/                 (the kind of machines we
must work with)

There are still a *lot* of lightweight applications giving real functionality
without bloat.
Of course, they can make little in these conditions if constantly swapped out from
the Kernel and/or X.

With 16 or 24 MB or RAM even half a meg less is very important. We at RULE are
doing what we can to select light GUI applications and test them with kdrive,
but have
no expertise to look after the kernel.

Any help whatsoever in keeping 2.6 as light as possible, and to recompile stock
2.4 kernels
to lighten them is really needed.

The most important part of this is that it is not a programming contest, just
for the sake of it.

There are literally thousands of schools, all over the world, which simply
cannot afford
any money on computers. The "HW is cheap" slogan is very cruel when recited in
places
where 64 MB of RAM are one month's salary. I am not kidding. All these schools
have is
donated computers 5+ years old: even if they had the money they could not find
spare parts
from them.

After food, medicines and shelter a good education is essential to make a decent
living.

It is extremely embarassing to tell these students "you can do without expensive
MS SW,
just find the money for a PC almost as expensive as those which will run Windows".

A lightweight Linux is needed to many more people than the full featured one

Thank you in advance for any support,

             Marco Fioretti, RULE project coordinator

PS: Oh, and while I'm at it, I'll even dare to ask for RULE network volunteers, see
http://www.rule-project.org/en/rule_by_email.php


