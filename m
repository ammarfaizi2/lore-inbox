Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267968AbRHBAGq>; Wed, 1 Aug 2001 20:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267946AbRHBAGg>; Wed, 1 Aug 2001 20:06:36 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:3719 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S267912AbRHBAGZ>;
	Wed, 1 Aug 2001 20:06:25 -0400
Message-ID: <3B689B50.33E84D33@randomlogic.com>
Date: Wed, 01 Aug 2001 17:14:08 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] DMCA loop hole
In-Reply-To: <Pine.BSO.4.33.0108010137240.7994-100000@aaieee.daisy-chan.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Jore wrote:
> 
> You know, I've heard this arguement a few times in various contexts and
> it's bothered me everytime. If a virus was designed with specific
> properties that hinder unauthorized copyright infringement then attempts
> to circumvent the limitations would be an example of DMCA circumvention.
> 
> This misses the whole point that in order to deliver the second and more
> important part of the virus requires the author to self-identify to the
> US federal government and somehow get them to prosecute the offender. Now
> at this point, how many of these authors aren't going to be immediately
> charged with something heinous for the act of writting the offensive thing
> in the first place? And do you seriously think you're going to convince
> Ashcroft and company to prosecute Symantec for getting rid of a virus even
> if it is DMCA 'protected'?
> 
> GAAAAA!
> 

It's very simple, and something like this is done all the time in the security industry by people who not only enjoy it, but who get paid to do it.

1)  Discover an exploit or a new way of using a known exploit.
2)  Write a trojan, virus, worm, etc. that takes advantage of the exploit.
3)* Report the exploit to the applicable compan(y/ies), Security Focus, etc. and provide the BINARY of your trojan, virus, or whatever so they can test the
exploit and find a fix.

* Usually people provide the source code as open software. In this case (for this argument) we release it as binary only and keep full rights.

No law was broken when the trojan, virus, etc. was written and no one can (technically) seek prosecution. Under DMCA (at least the way the writers of it have
used it), anyone attempting to reverse engineer your virus (or whatever) and provide an antigen, is liable to you and you can sue them.

To take another angle, those of us who actively look for exploits in software (because companies like M$ fail to do so themselves) risk being sued for doing so.
This makes jobs like mine EXTREMELY difficult because on the one hand I don't want my company using software that will allow Joe Cracker to take over our
machines, and on the other I don't want the company sued just because I did some necessary reverse engineering in order to prevent it (again, because the
software mfg. can't be trusted to do it themselves).

PGA

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
