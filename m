Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314228AbSDRP0i>; Thu, 18 Apr 2002 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314334AbSDRP0h>; Thu, 18 Apr 2002 11:26:37 -0400
Received: from bitmover.com ([192.132.92.2]:62923 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314228AbSDRP0h>;
	Thu, 18 Apr 2002 11:26:37 -0400
Date: Thu, 18 Apr 2002 08:26:36 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Linux on s/390 is cute
Message-ID: <20020418082636.O2710@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I took advantage of IBM's public mainframe system running Linux and 
compiled up a copy of BitKeeper on it.  Didn't have to change a single
line, just worked, thanks to gcc -Wall and friends.

This isn't a BK thing, it's a Linux thing.  It's amazingly cool to me
that Linux runs on stuff as small as all sorts of embedded devices,
up to tiny PC's like a netwinder, all the way up to mainframes.

I'd really like to see the IBM guys let the walls between the linux
instances down a bit.  If I could mmap the other linux instances
memory, that's a kickass system.

Anyway, kudos to the people who did the Linux/390 stuff, we'll
include it in our list of supported platforms next release.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
