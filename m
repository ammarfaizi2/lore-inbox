Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTJLU0a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 16:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTJLU0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 16:26:30 -0400
Received: from smtp1.songnet.fi ([194.100.2.121]:52533 "EHLO smtp1.songnet.fi")
	by vger.kernel.org with ESMTP id S263529AbTJLU01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 16:26:27 -0400
Message-ID: <1065990395.3f89b8fb73015@mail.hellfish.org>
Date: Sun, 12 Oct 2003 23:26:35 +0300
From: anlar@hellfish.org
To: linux-kernel@vger.kernel.org
Subject: Future of the security features
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 130.234.192.229
X-Service-Provided-by: Hellfish
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been playing with the Grsecurity (www.grsecurity.org) patches now for a
while and I wouldn't run a server anymore without it. I noticed from the kernel
list archives that the inclusion of features like Pax have been discussed
before and as I have understood, this might be a good time to try to get the
matter hot again.

There are a lot of nice security improving patches for the kernel. Pax against
many of the overflows in software for instance could be one nice day saving
feature. Making such features upstream would not cure the situation alone. I
believe though that it would help generally in making our computing safer.

Just take a look at all the small tweaks and improvements that are available
for
instance in Grsecurity. Whoa. Not bad. Would break some (poorly designed
mostly) software though if forced on. (The only really problematic in my
experience has been the Xfree86 server but even it can be fixed afaik to run
with all the Grsecurity patches.)

The Linux kernel could be tweaked to be one nasty animal (can penguins be
nasty?) guarding the security. Linux based systems could be a lot more secure
with "some light tweaking" and now it is mostly up to the kernel developers.
So, why not?

To remind you, even Windowses are going that way. Including that kind of
features. (No, not yet available. They just recompiled some of their software
with stack protection stuff that is on the newest compilers of theirs.) You
don't want the Linux to be laughed at. :) Heh.


