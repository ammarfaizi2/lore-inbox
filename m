Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278439AbRJMXEO>; Sat, 13 Oct 2001 19:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278438AbRJMXEA>; Sat, 13 Oct 2001 19:04:00 -0400
Received: from zok.sgi.com ([204.94.215.101]:53377 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278437AbRJMXDn>;
	Sat, 13 Oct 2001 19:03:43 -0400
Message-ID: <3BC8C86D.4C48828C@sgi.com>
Date: Sat, 13 Oct 2001 16:04:13 -0700
From: L A Walsh <law@sgi.com>
Organization: Trust Technology, Core Linux, SGI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: John J Tobin <ogre@sirinet.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Maximum size of ext2 files on ia32 is?
In-Reply-To: <3BC8AE84.48808982@sgi.com> <1003013547.14180.1.camel@ogre>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John J Tobin wrote:> 
> I had the same problem awhile back it it was attributed to using
> outdated fileutils. I recommend getting new ones from www.gnu.org and
> seeing if that fixes the problem. It fixed it when I had a similar
> problem.
---
	Hmmm.  I have a server at work installed from RH7.1 running 2.4.4.
I did a grep of many files into redirected into a file and that fails at
2G.  But my version of 7.2 Suse doesn't.  I take it this is a recent update
to the file utils?

-linda

--  -    _    -    _    -    _    -    _    -    _    -    _    -    _    -
L A Walsh, law at sgi dot com     | Senior Engineer
01-650-933-5338                   | Trust Technology, Core Linux, SGI
