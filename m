Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287177AbSABXEh>; Wed, 2 Jan 2002 18:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287166AbSABXCq>; Wed, 2 Jan 2002 18:02:46 -0500
Received: from ns.crrstv.net ([216.94.219.4]:4755 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S287170AbSABXCf>;
	Wed, 2 Jan 2002 18:02:35 -0500
Date: Wed, 2 Jan 2002 19:01:08 -0400 (AST)
From: skidley <skidley@crrstv.net>
X-X-Sender: skidley@localhost.localdomain
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Keith Owens <kaos@ocs.com.au>, adrian kok <adriankok2000@yahoo.com.hk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: system.map
In-Reply-To: <200201022117.g02LHbSr022224@svr3.applink.net>
Message-ID: <Pine.LNX.4.43.0201021853300.2334-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Timothy Covell wrote:
 
> However, I'm concerned about searching in "/usr/src/linux" for it.
> Linus has taken great pains to point out that we shouldn't be building
> our kernels in /usr/src/linux, it would seem that this is reenforcing a
> mistake.
> 
I'm curious as to why kernels shouldn't be built in /usr/src/linux. Also
this may be a dumb question but if I have built my kernels in /usr/src and want to move them to /home for eg. will that screw up things? Installing some apps from source sometimes they search for the kernel source during configure. If a kernel was compiled and moved to a different dir will this matter? 

-- 
  . ---                                   .----.
  |o_o |                                 /_ 0  |      
  |:_/ |   Give Micro$oft the Bird!!!!   \_    |
 //   \ \  Use Linux!!!!                 /      \
(|     | )                              | )  | | | 
/'\_   _/`\                             | )  | | |   
\___)=(___/                             |_)  (_) |  
Chad Young                               \______/
Registered Linux User #195191           (_______|
@ http://counter.li.org
-----------------------------------------------------------------------
Linux localhost 2.4.18pre1 #2 Fri Dec 28 14:41:58 AST 2001 i686 unknown
  6:50pm  up  4:35,  4 users,  load average: 0.01, 0.00, 0.00

