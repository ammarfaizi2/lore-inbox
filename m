Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270999AbRHYCqi>; Fri, 24 Aug 2001 22:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271367AbRHYCq3>; Fri, 24 Aug 2001 22:46:29 -0400
Received: from web10404.mail.yahoo.com ([216.136.130.96]:25616 "HELO
	web10404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270999AbRHYCqK>; Fri, 24 Aug 2001 22:46:10 -0400
Message-ID: <20010825024627.30130.qmail@web10404.mail.yahoo.com>
Date: Sat, 25 Aug 2001 12:46:27 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.4 broken on 486SX
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B86BAF0.489E92C6@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, I got this strange thing too but with
2.2.19. I got the kernel 2.2.19 source from slackware
site, compile it using gcc 2.95.3 and select CPU as
486, but the compiled image can not run in my 486 CPU
(it does run fine in the machine I compile it i686).
There is no way. Ironically 2.4.x works for me, if I
choose 486, I can run it on 486. 

I noticed the differrence in the cflags in 2.2.19 it
is like  -m486 -DCPU=i486  and in 2.4.x it is
-march=i486 instead of -DCPU=i486. According to gcc
documentation it is the same. Why it is like that ? 



=====
S.KIEU

_____________________________________________________________________________
http://shopping.yahoo.com.au - Father's Day Shopping
- Find the perfect gift for your Dad for Father's Day
