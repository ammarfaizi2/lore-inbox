Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262461AbSJETbR>; Sat, 5 Oct 2002 15:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262463AbSJETbR>; Sat, 5 Oct 2002 15:31:17 -0400
Received: from web13202.mail.yahoo.com ([216.136.174.187]:49726 "HELO
	web13202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262461AbSJETbO>; Sat, 5 Oct 2002 15:31:14 -0400
Message-ID: <20021005193650.17795.qmail@web13202.mail.yahoo.com>
Date: Sat, 5 Oct 2002 12:36:50 -0700 (PDT)
From: Gigi Duru <giduru@yahoo.com>
Subject: The end of embedded Linux?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial experiment: configure out _ALL_ the options on
2.5.38 and build bzImage. My result? A totally useless
270KB kernel (compressed). 

Now try to put in some useful stuff and the
_compressed_ image will cheerfully approach 1MB. Where
are the days when a 200KB kernel would be fully
equipped?

I know you guys are struggling to bring "world class
VM & IO" to Linux, going for SMPs and other big toys,
but you are about to lose what you already have: the
embedded market.

As an embedded developer, I can't stand bloat. I think
an OS designer should feel the same, and develop in a
fully modular and configurable manner, going for both
speed and size. For a long time I've felt that Linux
has got it right, but lately I'm not that sure
anymore. 

Gigi Duru

__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
