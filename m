Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286650AbSABCta>; Tue, 1 Jan 2002 21:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286654AbSABCtU>; Tue, 1 Jan 2002 21:49:20 -0500
Received: from [208.179.59.195] ([208.179.59.195]:22868 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S286650AbSABCtG>; Tue, 1 Jan 2002 21:49:06 -0500
Message-ID: <3C327489.5030905@blue-labs.org>
Date: Tue, 01 Jan 2002 21:46:33 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011231
X-Accept-Language: en-us
MIME-Version: 1.0
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB
In-Reply-To: <200201010635.g016ZR6X014712@sleipnir.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>It is not for anybody who handles large amounts of mail. I have yet to see
>a browser which does even a half-assed attempt at doing email right.
>

I handle thousands of emails a day, over a hundred emails distinctly to 
me, not a list.  I like mozilla most, but don't think I like the 
footprint or everything about it ;)

>Here (emacs + mh-e): ^ on the message, RET to confirm the folder. Managing?
>No sweat, it is just another mail folder, to be handled by the same
>commands my fingers do on their own now.
>

As I mentioned to DJ, this is fine for you, your personal database, but 
it serves no purpose for anyone else and doesn't scale well for large 
amounts of reference material.

>Plus the problem that thousands of (well meaning, but completely useless)
>reports clog up bug<foo>, rquiring hand-cleaning by somebody who _really_
>knows about the system. I.e., exactly the person whose work you want to
>spare.
>

Untidied bug reports can be flushed out of the system, they can be 
<insert action>.  By making a more intuitive system, these bug reports 
could be fleshed out better or coallated when appropriate.  By having an 
open system, anyone can do the maintenance.  You can choose different 
pools for the entries and keep the chaff "outside" until it is weeded 
through or discarded.

>Look at the FAQ for the kernel (helpfully compiled by this list). Problems
>that get identified tend to get fixed fast, so working at documenting them
>in detail makes no sense at al.
>
>If you want to know what is broken in _development_ kernels, you have to
>read this list.
>

Not everything needs to be documented or documented in detail. 
 Sometimes a simple "loopback compile err, 'loopback.c:417:foo is not 
defined' is fixed in 2.2.2." is quite sufficient.  People with 2.2.1 
will recognize the need to upgrade or generate a patch to solve their 
problem.  The FAQ doesn't address everything and not everything is 
broken.  A 'bug' database is sometimes a misnomer.

Neither the DB nor the list replace each other.  They augment each other.

David



