Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311707AbSCNSTR>; Thu, 14 Mar 2002 13:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311709AbSCNSTH>; Thu, 14 Mar 2002 13:19:07 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:41369 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S311707AbSCNSTB>;
	Thu, 14 Mar 2002 13:19:01 -0500
Message-ID: <3C90E994.2030702@candelatech.com>
Date: Thu, 14 Mar 2002 11:19:00 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
In-Reply-To: <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Larry McVoy wrote:


> Hi, Linus & Marcelo agreed that the right place for this is
> 
> 	bk://linux.bkbits.net/linux-2.4


I did a clone with this.  However, I see no files, only
directories.  The files do seem to be in the SCCS directories,
but I don't know how to make them appear in their normal place.

The command I ran was:
  bk clone bk://linux24.bkbits.net/linux-2.4

Here is what the resulting linux-2.4 directory looked like:

[greear@grok bk]$ cd linux-2.4/
[greear@grok linux-2.4]$ ls -alt
total 64
drwxrwxr-x    6 greear   greear       4096 Mar 14 11:03 BitKeeper
drwxrwxr-x   16 greear   greear       4096 Mar 14 11:03 .
drwxrwxr-x    5 greear   greear       4096 Mar 14 11:03 scripts
drwxrwxr-x   29 greear   greear       4096 Mar 14 11:03 net
drwxrwxr-x    3 greear   greear       4096 Mar 14 11:03 lib
drwxrwxr-x    3 greear   greear       4096 Mar 14 11:03 mm
drwxrwxr-x   24 greear   greear       4096 Mar 14 11:03 include
drwxrwxr-x    3 greear   greear       4096 Mar 14 11:03 init
drwxrwxr-x    3 greear   greear       4096 Mar 14 11:03 ipc
drwxrwxr-x    3 greear   greear       4096 Mar 14 11:03 kernel
drwxrwxr-x   46 greear   greear       4096 Mar 14 11:02 fs
drwxrwxr-x   40 greear   greear       4096 Mar 14 11:01 drivers
drwxrwxr-x   17 greear   greear       4096 Mar 14 10:58 arch
drwxrwxr-x   29 greear   greear       4096 Mar 14 10:57 Documentation
drwxrwxr-x    2 greear   greear       4096 Mar 14 10:57 SCCS
drwxrwxr-x    3 greear   greear       4096 Mar 14 10:57 ..
[greear@grok linux-2.4]$

What am I missing?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


