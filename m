Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286289AbSAAP5I>; Tue, 1 Jan 2002 10:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286273AbSAAP46>; Tue, 1 Jan 2002 10:56:58 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:58886 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S286289AbSAAP4o>;
	Tue, 1 Jan 2002 10:56:44 -0500
Message-Id: <200201010635.g016ZR6X014712@sleipnir.valparaiso.cl>
To: David Ford <david+cert@blue-labs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB 
In-Reply-To: Your message of "Mon, 31 Dec 2001 14:27:18 CDT."
             <3C30BC16.6070809@blue-labs.org> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Tue, 01 Jan 2002 03:35:27 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david+cert@blue-labs.org> said:

[...]

> That's a bit of apples and oranges ;)
> 
> Starting a browser is equivalent to starting a mail client.  In some 
> instances it's the same program.

It is not for anybody who handles large amounts of mail. I have yet to see
a browser which does even a half-assed attempt at doing email right.

> Hitting 2-3 keypresses to archive an email...how do you manage that 
> archive v.s. it being managed for you w/ bugzilla?

Here (emacs + mh-e): ^ on the message, RET to confirm the folder. Managing?
No sweat, it is just another mail folder, to be handled by the same
commands my fingers do on their own now.

> Logging into bugzilla can be automatic, searching for a bug across the 
> archive is in my opinion much more easily done w/ a relational database 
> than grepping several mbox files that collect hundreds of messages a 
> day.  Not to mention that comments on each bug are localized to -that- 
> bug.  All said and done there are a lot of pros and cons from the newbie 
> v.s. the 'Linus' perspective.  I think there is at least one or two 
> irate persons per week here that have been fighting to find a solution 
> to their problem and someone finally speaks up "oh yeah, do this".

Plus the problem that thousands of (well meaning, but completely useless)
reports clog up bug<foo>, rquiring hand-cleaning by somebody who _really_
knows about the system. I.e., exactly the person whose work you want to
spare.

> It really would be nice to have a reference database -somewhere- where 
> we could find answers or even just suggestions about the myriad of 
> problems related to the kernel and what the kernel touches.

Look at the FAQ for the kernel (helpfully compiled by this list). Problems
that get identified tend to get fixed fast, so working at documenting them
in detail makes no sense at al.

If you want to know what is broken in _development_ kernels, you have to
read this list.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
