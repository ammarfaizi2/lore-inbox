Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287619AbRLaTn3>; Mon, 31 Dec 2001 14:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287620AbRLaTnT>; Mon, 31 Dec 2001 14:43:19 -0500
Received: from [208.179.59.195] ([208.179.59.195]:28493 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S287619AbRLaTnG>; Mon, 31 Dec 2001 14:43:06 -0500
Message-ID: <3C30BF2B.10406@blue-labs.org>
Date: Mon, 31 Dec 2001 14:40:27 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011231
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Stewart Smith <stewart@softhome.net>, timothy.covell@ashavan.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB
In-Reply-To: <Pine.LNX.4.33.0112301306070.6995-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I had the time to do it or subsistence backing to do it, I would.

I'd write the bugzilla concept that interfaced w/ lkml to automatically 
run queries and email results to "loop doesn't compile".  It would also 
cross check at bug submission time for possible dupe entries and ask the 
submitter if he really wanted to continue.

If you make it easy to use and it has the answers you need, it will 
create it's own success and by that, it'll draw a lot of these lkml 
repeats from the list.  the SNR will increase and users will be happier. 
 Instead of going to google and getting 947 mostly similar pages to the 
same sender/replier and 3 pages that you actually could use..you could 
visit the kernel bugkeep lair.

What is needed is a well designed interface to a DB, not YAB (yet 
another bugtracker) that isn't intuitive and thus won't be used.  Most 
of the reason why such a DB is looked down on is because we have seen 
way too many wonderful new ideas that have a horrible UI.  So people 
don't like it or the 20 that came before it, so they expect the next new 
wonderful idea to also turn out bad.  Not to mention that the author 
didn't do it exactly like they envisioned it.

David

>it still requires some dumb^Wpoor sap to go in pruning them,
>plus once it gets to a certain point, there will be dupes.
>Oh boy will there be dupes. People will check for them first you say?
>Some people are _still_ getting "Loop doesn't compile in 2.4.14"
>messages.
>Why search archives when you can be the 900th person to ask the
>same question.  Even Richard Gooch's page for showing whats wrong
>with the current kernel and how to fix it to get it to compile
>seems to be completly overlooked. Maybe if it were moved to
>www.kernel.org people would see it ? *shrug*
>


