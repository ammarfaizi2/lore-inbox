Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbRLaTa1>; Mon, 31 Dec 2001 14:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287609AbRLaTaR>; Mon, 31 Dec 2001 14:30:17 -0500
Received: from [208.179.59.195] ([208.179.59.195]:25677 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S284732AbRLaTaH>; Mon, 31 Dec 2001 14:30:07 -0500
Message-ID: <3C30BC16.6070809@blue-labs.org>
Date: Mon, 31 Dec 2001 14:27:18 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011231
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Stewart Smith <stewart@softhome.net>, timothy.covell@ashavan.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB
In-Reply-To: <Pine.LNX.4.33.0112300038040.1336-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>The advantage email has over this are too numerous to list,
>but they start with the fact that lots of kernel developers are
>lazy[*]. 2-3 keypresses to archive a patch for looking at later/merging
>are about the level of involvement thats aimed for.
>Having to start a browser, go to the bugzilla site, log in, search/browse
>for bugs etc.. way too involved.
>
>Dave.
>
>[*] In the sense that if life can be made easier, it should be.
>

That's a bit of apples and oranges ;)

Starting a browser is equivalent to starting a mail client.  In some 
instances it's the same program.

Hitting 2-3 keypresses to archive an email...how do you manage that 
archive v.s. it being managed for you w/ bugzilla?

Logging into bugzilla can be automatic, searching for a bug across the 
archive is in my opinion much more easily done w/ a relational database 
than grepping several mbox files that collect hundreds of messages a 
day.  Not to mention that comments on each bug are localized to -that- 
bug.  All said and done there are a lot of pros and cons from the newbie 
v.s. the 'Linus' perspective.  I think there is at least one or two 
irate persons per week here that have been fighting to find a solution 
to their problem and someone finally speaks up "oh yeah, do this".

It really would be nice to have a reference database -somewhere- where 
we could find answers or even just suggestions about the myriad of 
problems related to the kernel and what the kernel touches.

David

[*] RDBMSs do make my life much easier


