Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRK3Wci>; Fri, 30 Nov 2001 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281103AbRK3Wce>; Fri, 30 Nov 2001 17:32:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23813 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281138AbRK3WcK>; Fri, 30 Nov 2001 17:32:10 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Coding style - a non-issue
Date: 30 Nov 2001 14:31:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9u91cn$v4i$1@cesium.transmeta.com>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <20011130110546.V14710@work.bitmover.com> <E169vcF-0000lQ-00@starship.berlin> <20011130140613.F14710@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011130140613.F14710@work.bitmover.com>
By author:    Larry McVoy <lm@bitmover.com>
In newsgroup: linux.dev.kernel
> > 
> > A simple rule to remember is: when code is bad, criticize the code, not the 
> > coder.
> 
> Your priorities are upside down.  The code is more important than the
> coder, it will outlive the coder's interest in that code.  Besides,
> this isn't some touchy feely love fest, it's code.  It's suppose to
> work and work well and be maintainable.  You don't get that by being
> "nice", you get that by insisting on quality.  If being nice worked,
> we wouldn't be having this conversation.
> 

So the sensible thing to do is, again, to criticize the code, not the
coder.

There are multiple reasons for that:

a) The code is what counts.
b) People take personal attacks, well, personally.  It causes
   unnecessary bad blood.
c) There are people who will produce beautiful code one minute, and
   complete shitpiles the next one.

If a certain piece of code is a shitpile, go ahead and say so.  Please
do, however, explain why that is, and please give the maintainer a
chance to listen before being flamed publically.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
