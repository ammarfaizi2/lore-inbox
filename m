Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319070AbSIDF4c>; Wed, 4 Sep 2002 01:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319071AbSIDF4c>; Wed, 4 Sep 2002 01:56:32 -0400
Received: from dp.samba.org ([66.70.73.150]:27618 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319070AbSIDF4b>;
	Wed, 4 Sep 2002 01:56:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
In-reply-to: Your message of "Tue, 03 Sep 2002 22:05:14 MST."
             <20020903.220514.21399526.davem@redhat.com> 
Date: Wed, 04 Sep 2002 16:00:35 +1000
Message-Id: <20020904060105.C263E2C1B6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020903.220514.21399526.davem@redhat.com> you write:
>    If you're not going to upgrade your compiler, will you accept a gcc
>    patch to fix this?  If so, where can I get the source to your exact
>    version?
>    
> Oh, "I'm" willing to upgrade "my" compiler, it's my users
> that are the problem.  If you impose 3.1 or whatever, I get less
> people testing on sparc64 as a result.

I understand.  It's OK to piss off one Sparc64 Linux user, but if you
piss off both of them, you're in trouble 8)

I was actually proposing to provide a patch to an egcs version of your
choice which you could provide as kgcc to your users.  But RH seem to
have taken down the SRPM for 2.92.11 (egcs64-19980921-4.src.rpm).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
