Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269778AbRHQGw4>; Fri, 17 Aug 2001 02:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269777AbRHQGwq>; Fri, 17 Aug 2001 02:52:46 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:26255 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269778AbRHQGwe>; Fri, 17 Aug 2001 02:52:34 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 16 Aug 2001 23:52:47 -0700
Message-Id: <200108170652.XAA07329@baldur.yggdrasil.com>
To: davem@redhat.com
Subject: Re: 2.4.9 does not compile
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   	The macro "min(n1,n2)", is a very standard practice in C
>   programming.

>If min() in it's "very standard practice" form is broken at
>the core, breaking it like I have is a fix.

	Granted, in some cases, I am in favor of the Linux kernel
being the innovator in violating some prevailing standards that I
regard as sufficientliy "broken at the core", like, say, the
popularity of really long variable names.  However, I think just about
nobody else in this discussion accepts the major premise of that
syllogism that min(n1,n2) is "broken to the core", at least not
to the degree that changing it that way is a fix.

>Let this go till Linus returns from Finland in a week or so,
>I'm sure he'll be more than happy to state why he wanted
>me to do these changes.

	OK.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
