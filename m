Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267754AbTBECye>; Tue, 4 Feb 2003 21:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTBECye>; Tue, 4 Feb 2003 21:54:34 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:13703 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267754AbTBECyc>; Tue, 4 Feb 2003 21:54:32 -0500
Date: Wed, 5 Feb 2003 04:03:51 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030205030351.GC21879@louise.pinerecords.com>
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com> <20030204232101.GA9034@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204232101.GA9034@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [lm@bitmover.com]
> 
> I can't offer any immediate help with this but I want the same thing.  At
> some point, we're planning on funding some extensions into GCC or whatever
> reasonable C compiler is around:
> 
>     - associative arrays as a builtin type
>     - regular expressions
>     - tk bindings built in

Is it April 1st already?

I can't see why this should be a language extension other than you want
to make a real mess out of it.

> and then we'll port BK to that compiler.  It's likely to be GCC because we
> want to support all the different architectures but if a kernel sponsered
> cc shows up we'll happily throw money at that.

Ever heard of glib?
#include <glib.h> and be done with it.

-- 
Tomas Szepe <szepe@pinerecords.com>
