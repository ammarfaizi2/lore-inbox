Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbSLTK2Y>; Fri, 20 Dec 2002 05:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267769AbSLTK2X>; Fri, 20 Dec 2002 05:28:23 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:36514 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267761AbSLTK2W>;
	Fri, 20 Dec 2002 05:28:22 -0500
Date: Fri, 20 Dec 2002 10:35:27 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Hanna Linder <hannal@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Eli Carter <eli.carter@inet.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
Message-ID: <20021220103527.GH24782@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Hanna Linder <hannal@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Eli Carter <eli.carter@inet.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <200212192155.gBJLtV6k003254@darkstar.example.net> <3E0240CA.4000502@inet.com> <42790000.1040337942@w-hlinder> <50260000.1040348396@flay> <71820000.1040349694@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71820000.1040349694@w-hlinder>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 06:01:34PM -0800, Hanna Linder wrote:

 > > Anything in "OPEN" state isn't really assigned to anyone yet.
 > > (the state would really better be named "NEW", but it's not). 
 > > People should move it to "ASSIGNED" if they're working on it.
 > 	So the process is to query for all open bugs (but not 
 > assigned) then email each person to let them know you are 
 > working on it?

Why generate noise ?

Query bugs.
Find something interesting.
Fix it.
THEN email person (or better yet, add to bugzilla entry).

Flooding the database with "I'm working on this" reports
buys absolutely nothing.

 > > Go to file a new bug, click on the link by the subcategories, and it'll
 > > tell you (you'll have to pick the main category first).
 > 	That is convoluted. You have to file a bug to find out who
 > the subsystem maintainers are? Can you put it somewhere more
 > obvious?

I think you're misunderstanding how things work.
The view you seem to have is to use bugzilla to find bugs,
and get a list of people who to email. This shuts out the
rest of the world who are watching that bug in bugzilla.

If you want to add to a bug reported in bugzilla, forget email,
just _use the tool_.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
