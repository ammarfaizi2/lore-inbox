Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTAQXES>; Fri, 17 Jan 2003 18:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTAQXES>; Fri, 17 Jan 2003 18:04:18 -0500
Received: from [81.2.122.30] ([81.2.122.30]:31494 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261645AbTAQXER>;
	Fri, 17 Jan 2003 18:04:17 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301172312.h0HNCuHO002622@darkstar.example.net>
Subject: [ANNOUNCE] Kernel Bug Database 2.0
To: linux-kernel@vger.kernel.org
Date: Fri, 17 Jan 2003 23:12:56 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on it all day, and I've finally got version 2.0
ready and working, and put it on-line:

http://grabjohn.com/kernelbugdatabase

I've added a major new concept in this version - bug reports and
confirmed bugs, (I.E. bugs which are being actively investigated by
somebody with administrative access to the Kernel Bug Database), are
now separate things.

In other words, anybody can submit a bug report, but only designated
people can collect those reports together into a confirmed bug.  A bug
report can be related to several confirmed bugs.  Confirmed bugs can
be read and commented on by all users.

Thanks to Fergal Daly for submitting this idea, and I'd also like to
point out that I read more or less the same idea in this email by
Larry McVoy, where Jens mentions the idea of sorting a queue of new
bugs into the real database.

http://www.cs.helsinki.fi/linux/linux-kernel/2001-13/0084.html

Hopefully this system also makes Alan's idea of keeping all bug
reports for data mining, (also mentioned above), more practical.

I haven't written any documentation for it yet, but hopefully it's
fairly self-explanatory anyway.

I've added a single confirmed bug, which relates to two vaguely
related bug reports, (missing help text, and a missing comment), but
anybody who wants administrative access to add and modify confirmed
bugs, just drop me an E-Mail.

As always, any feedback on this would be much appreciated.

John.
