Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRBXRv4>; Sat, 24 Feb 2001 12:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129488AbRBXRvq>; Sat, 24 Feb 2001 12:51:46 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:52268 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129466AbRBXRvd>; Sat, 24 Feb 2001 12:51:33 -0500
Date: Sat, 24 Feb 2001 12:50:57 -0500 (EST)
From: Jon Eisenstein <jeisen@mindspring.com>
Reply-To: jeisen@mindspring.com
To: linux-kernel@vger.kernel.org
Subject: Odd network problems
Message-ID: <Pine.LNX.4.21.0102241235310.30688-100000@dominia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have sent this question to 3 other mailing lists already without
success, so hopefully there is an answer related to kernel that can be
answered here. For some strange, unidentifiable reason, I cannot reach
certain sites through any web browser. Pinging the site responds well, as
does traceroute, and telnetting to port 80 on the machine connects me to
the site. However, once connected, no web commands are working, and any
programs simply hang at this point. Using lynx (as an example; all web
browsers on my machine have this problem), a connection is established,
but the program hangs on "HTTP request sent; waiting for response." I have
waited overnight for a response, but it stays at that point.

I have tested this in any way I could think of. I have telnetted to other
Linux machines, and found that they can reach the site without
difficulty. I have tried using my other computer, which shares the phone
line, internet account and settings, but runs Windows 98. Again, no
difficulty. I have removed all software that might be acting as a
firewall, removed local DNS services and have rebooted to verify that it
is not a cache issue. I have also checked the FAQ, and tried to follow the
directions for problems with ECN, but do not have a file named
/proc/sys/net/ipv4/tcp_ecn. (I am using devfs, if that makes a
difference.)

If this is not a kernel issue, then I hope someone can direct me to some
other way of fixing this problem. If a solution cannot be offered, then
advice about how to trace this problem would also be welcomed.

Here is a partial list of sites that I have had problems with. Note that
once I find one of these sites, it is consistantly unreachable, even with
sites found months ago.

www.codewarrioru.com
www.backwire.com
www.counterpane.com
www.zip2it.com

Thank you for any help you might be able to provide.

----

Jonathan Eisenstein
jeisen@mindspring.com

PGP Public Key: http://www.mindspring.com/~jeisen/pgp.asc

