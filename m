Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268187AbTBNBMk>; Thu, 13 Feb 2003 20:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268191AbTBNBMk>; Thu, 13 Feb 2003 20:12:40 -0500
Received: from franka.aracnet.com ([216.99.193.44]:39829 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268187AbTBNBMi>; Thu, 13 Feb 2003 20:12:38 -0500
Date: Thu, 13 Feb 2003 17:21:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Larson <plars@linuxtestproject.org>
cc: davej@codemonkey.org.uk, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.60 cheerleading...
Message-ID: <19450000.1045185685@[10.10.2.4]>
In-Reply-To: <1045159485.28494.47.camel@plars>
References: <200302131711.h1DHBduR014118@darkstar.example.net>
 <1045159485.28494.47.camel@plars>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why?  That would just delay releases, and make more work for Linus.
> What I just suggested would be a short 1 line note to lkml.  I know he's
> very busy, but what's that, like 10 seconds?
> 
>> If a release is badly broken, another one is usually quick to follow
>> it, anyway.
> There's usually a lag of 30min to an hour between the last changeset and
> the the one that changes the version tag anyway.  I would
> hope/assume(dangerous) this is when it's beeing built and tested.  One
> more script to that mix that runs a subset of ltp might add an
> additional 5 min.  Alternatively, a note of intent to lkml might add a
> few seconds to that delay.
> 
> If I counted timezones etc. right, here's a quick picture of the number
> of minutes between the last changeset and the changeset that tagged it
> with the version number:
> 2.5.60 52 min.
> 2.5.59 42 min.
> 2.5.58 31 min.
> 2.5.57 16 min.
>  *** 2.5.58 was release something like 12 hours later
> 
> Is it less work to do a few minutes of extra testing, or go through
> another release in the same day?

Or you just persaude Linus to release kernels first thing in the morning,
not last thing at night. Then the automatic nightly tests would cover it
...(assuming you wake up before he does, and email him the results ... but
you're 2hrs earlier than him, so ... ;-))

M.

