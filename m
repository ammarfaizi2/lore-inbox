Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266750AbSKOVZN>; Fri, 15 Nov 2002 16:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266754AbSKOVZN>; Fri, 15 Nov 2002 16:25:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45785 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266750AbSKOVZM>;
	Fri, 15 Nov 2002 16:25:12 -0500
Date: Fri, 15 Nov 2002 13:30:04 -0800 (PST)
Message-Id: <20021115.133004.65979948.davem@redhat.com>
To: mbligh@aracnet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <336460000.1037398316@flay>
References: <396026666.1037298946@[10.10.2.3]>
	<1037395835.22209.3.camel@rth.ninka.net>
	<336460000.1037398316@flay>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <mbligh@aracnet.com>
   Date: Fri, 15 Nov 2002 14:11:56 -0800

   Right, but look at the flip side ... once that bug has been logged
   in bugzilla, the person who would have emailed lkml now has an easily
   searchable interface, and could have found the bug, found out what the
   patch for it was, and fixed it themselves, without ever bothering you,
   lkml, or anyone. I'm not saying that'll happen 100% of the time, but 
   it should help overall ... will just take a short period whilst data 
   builds up.
   
I'm more concerned about the inevitable explosion of duplicates
and "fixed already"'s.

This is why a lot of people warned early on, and were wary about,
having someone full time managing and watching over this bug database.
It is specifically to deal with dups and things of this nature.

I don't want to be concerned about spending each morning closing a
screenful of dups or "fixed already" reports.  Then the bug database
isn't helping me, it's rather making more work for me.

This work is someone else's job.  On linux-kernel, we have a "someone
else" to do this already, the entire readership of linux-kernel. :-)

In bugzilla however, all of this work now must be done by whoever at
OSDL is watching over the bugzilla database all day long and _ME_.
That is an inefficient use of resources.

Even if the whole readership of linux-kernel moved over and started
watching over the bug database as they do now with the lists, that
still leaves tons of work for me because only I can click on the
"CLOSE" button for the bug report.  I want the whole readership of
linux-kernel to have this capability, to close the bug.  This way I
can do what I do with linux-kernel when I'm just too damn busy to read
that day's posting, hit the big delete key.
