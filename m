Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270903AbRHNWUZ>; Tue, 14 Aug 2001 18:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270902AbRHNWUP>; Tue, 14 Aug 2001 18:20:15 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:6027 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S270898AbRHNWUF>;
	Tue, 14 Aug 2001 18:20:05 -0400
Message-ID: <3B79A5D2.3F373D15@randomlogic.com>
Date: Tue, 14 Aug 2001 15:27:30 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
In-Reply-To: <E15Wddp-00016h-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > If this is truely the case, I'd suggest that kernel.org be modified, as
> > it refers to them as *stable*
> > as of 9:18PM PDT, direct copy & paste from kernel.org page:
> >
> > The latest stable version of the Linux kernel is: 2.4.8 2001-08-11 04:13
> > UTC Changelog
> >
> > The latest prepatch (alpha) version appears to be: 2.4.9-pre3 2001-08-13
> > 23:56 UTC Changelog
> 
> Kernel.org certainly should list the 2.2 status (hey I maintain it I'm
> allowed to be biased). Its unfortunate it many ways that people are still so
> programmed to the "latest version" obsession of the proprietary world some
> times. For most people 2.4 is the right choice but for absolute stability
> why change 8)

Agreed. 2.2.x works just fine for us on our servers (some have been up for over a year, some maybe longer, but the longer they're up without problems, the
easier it is to forget they even exist ;) I am using 2.4 because my personal MoBo is so new, it's the only kernel that will work worth a darn on it. I am also
wanting to upgrade some servers as soon as a more stable kernel is available because there are some improvements in the newer kernels that I feel could be of
great benefit (but then that's my personal view, and not necessarily a company view). It has been long known that even numbered kernels are stable kernels, not
necessarily bug free (nothing is, escept for what I write ;-), and odd numbered are development kernels. By this definition, 2.4.x kernels are stable (in most
cases it seems it's the hardware that's not).

PGA

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
