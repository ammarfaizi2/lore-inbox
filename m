Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSGXTmm>; Wed, 24 Jul 2002 15:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSGXTmm>; Wed, 24 Jul 2002 15:42:42 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:58564 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S318184AbSGXTml>;
	Wed, 24 Jul 2002 15:42:41 -0400
Date: Wed, 24 Jul 2002 14:40:15 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5 Problem Reports Status 
Message-ID: <Pine.LNX.4.44.0207241401570.26254-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a followup on a little project I've been playing around with for 
the past few days.  This project is to track problem reports, oops, bugs, 
etc for the devleopment kernel.  Hopefully it will prove useful.  Several 
points about this:

- I'm NOT going to track the various typos, thinkos, and minor syntax 
errors.  I'm aiming more for things such as the IDE problem, the broken 
flock, and odd memory corruption problems which entail more extended 
discussion than a simple one-line code fix.  It's going to be more of a 
judgement call as to what is included and what isn't.

- In the extended discussions I plan on omitting various bits I consider 
flamage not pertinent to the subject.  If anyone has a gripe with my 
editing, please contact me off-list.

- I received some feedback saying that I ought to merely point at archived 
threads for fixes, etc.  I considered that, but it seems that an edited 
discussion might be more useful.  This is especially evident in cases 
where the flow of messages go from point to point.  In this case editing 
out headers and superfluous attributions makes it look better to my eyes.

- It was also suggested that I'm merely duplicating existing TODO lists 
and other material.  Maybe.  One thing it has done was make me think more 
than superficially about some issues I hadn't paid attention to before.  

- To keep the list "clean" I plan on archiving previously fixed issues, 
only brining forward to a new kernel release report those issues which 
haven't been "closed."  An item's status can be open (discussion 
continues, no generally agreed upon solution available), proposed fix (a 
patch is available and is being tested and discussed),  tested fix 
(generally agreed upon and in a major maintaners -- aa,ac,dj -- patchset 
and ready for merging), and closed when it is integrated into the next 
Linus-blessed version.

The following list can be found at http://members.cox.net/tmolina

Kernel Problem Reports as of 24 Jul 1900 Zulu

Software Suspend Failure -- open
big IRQ lock removal     -- proposed fix 
CPU Detection            -- proposed fix
Swapper oops             -- open
Time jump/kernel freeze  -- open
IDE problem              -- open
RAID initialization      -- open
free_pages_ok            -- proposed fix
console lockup           -- open
slab page problem        -- proposed fix 
tcp_v6_get_port          -- proposed fix
RAID shutdown            -- open
Broken flock             -- proposed fix 
odd memory corruption    -- proposed fix
Broken Floppy            -- open


