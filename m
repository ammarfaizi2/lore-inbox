Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSELWhQ>; Sun, 12 May 2002 18:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSELWhP>; Sun, 12 May 2002 18:37:15 -0400
Received: from web20109.mail.yahoo.com ([216.136.226.46]:61967 "HELO
	web20109.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314551AbSELWhP>; Sun, 12 May 2002 18:37:15 -0400
Message-ID: <20020512223710.41173.qmail@web20109.mail.yahoo.com>
Date: Sun, 12 May 2002 15:37:10 -0700 (PDT)
From: Jennifer Huang <carrothh@yahoo.com>
Subject: Question about cpu time accuracy.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a question about cpu time accuracy.

I am using kernel 2.4.18. But, when I tried "utime"
and "nanosleep" to get a process suspended, it only
worked in 10ms granularity, and it's no way to sleep
for 1 microsecond.

Anyone can help me out of this?
Thanks in advance,

-Jenny

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
