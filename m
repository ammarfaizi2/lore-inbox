Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268917AbRHBMmy>; Thu, 2 Aug 2001 08:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268920AbRHBMmp>; Thu, 2 Aug 2001 08:42:45 -0400
Received: from zok.SGI.COM ([204.94.215.101]:55986 "EHLO zok.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S268919AbRHBMmj>;
	Thu, 2 Aug 2001 08:42:39 -0400
From: Jack Steiner <steiner@sgi.com>
Message-Id: <200108021242.HAA02573@fsgi055.americas.sgi.com>
Subject: Re: [Linux-ia64] [RFC] /proc/ksyms change for IA64 (fwd)
To: linux-kernel@vger.kernel.org
Date: Thu, 2 Aug 2001 07:42:45 -0500 (CDT)
In-Reply-To: <22393.996723520@kao2.melbourne.sgi.com> from "Keith Owens" at Aug 02, 2001 01:38:40 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with old modutils, modules will oops.  I don't see this as a problem,
> the IA64 population is fairly small, in any case gcc cross compile for
> IA64 has problems right now.
> 

The proposal looks fine. I have another question.

What problems exist with cross compiling.

We are still using the cross-compiler for all of our building & testing.
We use:
	gcc version 2.96-ia64-000717 snap 001117 (plus some patches that Ralf added last Dec).


I know that at some point we need to convert to native builds but right now we
dont have sufficient bigsur/lion boxes to do that.

We have not seen any problems with the compiler we are using - at least we 
have not attributed a problem to the compiler.

Should we upgrade to gcc3.0 yet???


Any info on this subject would be appreciated......

-- 
Thanks

Jack Steiner    (651-683-5302)   (vnet 233-5302)      steiner@sgi.com

