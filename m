Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270279AbRHWUln>; Thu, 23 Aug 2001 16:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270273AbRHWUld>; Thu, 23 Aug 2001 16:41:33 -0400
Received: from mx3.port.ru ([194.67.57.13]:21765 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S270264AbRHWUlY>;
	Thu, 23 Aug 2001 16:41:24 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.173]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15a1IJ-000KjA-00@f10.mail.ru>
Date: Fri, 24 Aug 2001 00:41:39 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

      Hey guys, can`t resist more this thread... =)

   1. I heard a lot of arguments why _not_ to include
  python. Also alot of arguments why _ignore_ the arguments
  to _not_ include python.
    BUT! No arguments why to _include_ it...
  kinda disbalance as i see.

  2. Those who tells that playing with 21M large kernel
 isnt any better than playing with kernel PLUS 20M
 python are, politely saying, definitely not right.

  3. i ALREADY cannot tolerate how current config
 heartbrakingly slow crawls on my p166. No, do not ask
 me why is it so. just think: we have 3k strings, 3k
 deps, and asketic ncurses interface. So WHY is it so
 slow? And you think python-powered config engine 
 will be at least _approachingly_ tolerable on an
 386??? Nah. It wont.

 What we win in the true C way: 
      speed, size
 What we lose --------=-------:
      maintainability?????? (i`ll believe if esr
 will tell so...)

---


cheers,


   Samium Gromoff
