Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283751AbRK3SWl>; Fri, 30 Nov 2001 13:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283748AbRK3SWa>; Fri, 30 Nov 2001 13:22:30 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:31620 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S283744AbRK3SVn>; Fri, 30 Nov 2001 13:21:43 -0500
Message-ID: <3C07CDFB.7F1A9FFC@randomlogic.com>
Date: Fri, 30 Nov 2001 10:20:43 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <20011130185359.Q31176@blu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

antirez wrote:
> 
> On Fri, Nov 30, 2001 at 11:47:28AM -0500, Jeff Garzik wrote:
> > The security community has shown us time and again that public shaming
> > is often the only way to motivate vendors into fixing security
> > problems.  Yes, even BSD security guys do this :)
> 
> It's a bit different. Usually the security community uses it
> when there isn't a way to fix the code (i.e. non-free code)
> or when the maintaner of the code refused to fix the issue.
> Also to "expose" the security problem isn't the same as
> to flame.
> 
> While not a good idea, something like a long name
> for a local var isn't a big problem like a completly
> broken software with huge security holes used by milions of people
> every day.
> 

A variable/function name should ALWAYS be descriptive of the
variable/function purpose. If it takes a long name, so be it. At least
the next guy looking at it will know what it is for.

PGA
-- 
Paul G. Allen
UNIX Admin II ('til Dec. 3)/FlUnKy At LaRgE (forever!)
Akamai Technologies, Inc.
www.akamai.com
