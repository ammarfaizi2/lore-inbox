Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbSJCTGF>; Thu, 3 Oct 2002 15:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJCTGF>; Thu, 3 Oct 2002 15:06:05 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:18051 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261363AbSJCTGE>;
	Thu, 3 Oct 2002 15:06:04 -0400
Date: Thu, 3 Oct 2002 14:11:37 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: Problem Report Project status
Message-ID: <Pine.LNX.4.44.0210031338360.5980-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing this project for a few weeks now and I think it's time to 
evaluate where I want to take it.  You all have had a chance to see what 
I've done and to judge whether it is useful or not.  I've been doing it as 
a startup demonstration to see if it was useful and whether I could do it.  
I'm fairly certain I can do it -- whether it is worth it is up to you all.

When I announced the project it was in response to informal exchanges with 
some of the major developers.  I had initially considered a bugzilla-type 
of project, but there were some drawbacks.  Bugzilla appears to have the 
capabilities I'm looking for, but I have/had some concerns.  My aim is to 
provide the kind of reporting, in an expanded form and format more readily 
accessible.  The problem is that I don't want to get in the way; I don't 
want the developers to have to go through extra effort, and I don't want 
the users reporting bugs to be required to go through extra effort to 
support this.

My current approach has some drawbacks.  I need to be able to associate 
messages in different threads with the same problem.  I need to be able to 
associate one message with several problems.  I need to be able to better 
track the status of fixes.  I know bugzilla can do all this, I just need 
to figure out whether I can set it up so I can do it without requiring a 
lot of extra work for users and developers.  If I can't, then it isn't as 
useful as it could be.

I'm going to spend this weekend looking at bugzilla and learning it.  I 
want to be able to create a problem tracking report and dump relevant 
messages from my kernel mailing queues into the database associated with 
that report.  I want to be able to associate a developer with each problem 
report group and track the status of fixes for the problem.  I want to be 
able to create reports for the mailing list from that database, as well as 
making it available online.

In the meantime, if I could get feedback on what I've been doing so far, 
whether what I've outlined is what you might expect, and any other 
suggestions you might have.  I was initially offered space on sourceforge.  
I'm assuming that offer is still good; if the feedback I get indicates I 
should go in the direction I've outlined, I'll contact them and set it up 
there.

Thanks in advance for your attention.

Tom

