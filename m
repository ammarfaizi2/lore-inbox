Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156016AbPKZA6U>; Thu, 25 Nov 1999 19:58:20 -0500
Received: by vger.rutgers.edu id <S155992AbPKZA57>; Thu, 25 Nov 1999 19:57:59 -0500
Received: from soil08.soil.nl ([132.229.135.68]:4424 "EHLO soil08.soil.nl") by vger.rutgers.edu with ESMTP id <S155970AbPKZA5k>; Thu, 25 Nov 1999 19:57:40 -0500
Date: Fri, 26 Nov 1999 01:57:27 +0100
From: Wichert Akkerman <wichert@soil.nl>
To: linux-kernel@vger.rutgers.edu
Subject: strace 4.1 released
Message-ID: <19991126015727.A2497@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0i
Sender: owner-linux-kernel@vger.rutgers.edu

Strace 4.1 has been released!

The most important changes in this release since the 4.0 release
are added support for Linux/MIPS, updates to the network-code
and of course a number Linux syscalls added or improved.

Please read the global README and the README for your OS when you
compile strace!

For Linux there are now also a couple of kernel patches available at
the strace homepage that make strace usage a bit more pleasant.

If you have questions, remarks or patches you can send those to the
strace mailinglist. You can subscribe by sending an email with the subject
"subscribe" to strace-request@lists.wiggy.net.  You can post to the list by
sending mail to strace@lists.wiggy.net.

You can get strace at two locations:
 * homepage at http://www.liacs.nl/~wichert/strace/
 * CVS archive at :pserver:anonymous@cvs.debian.org:/cvs/strace,
   password is empty

Wichert.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
