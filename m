Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbTFUBIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 21:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbTFUBIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 21:08:37 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:26349 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S265063AbTFUBIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 21:08:36 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Message-Id: <20030621012241.C204E194A9@macp.eti.br>
Date: Fri, 20 Jun 2003 22:22:41 -0300 (BRT)
From: marcelo@macp.eti.br (marcelo)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Between jobs now, but I was a technical consultant for one for the 2nd tier
database companies in the market, having been technical support before, for a
total of over 10 years. I think I can give some extra perspective to the issues
of inovation.

I will use the word copy and sucks from now on very liberaly.

All the really good people that worked for development on this company came
from other database companies. There was IBM people, DEC people, Sybase people.

A lot of the features they implemented on the database were based on features
the other guys had.

I also paid close attention to ORACLE as our largest competitor. What they were
doing was also largely implementing what was in the relational books, and what
other databases had. Not a whole lot of inovation. Marketing and I would dare
say bribing customers was what made ORACLE so big at first place.

Now onto operating systems. Microsoft's Win95 and follow-ons were in large part
copies of ideas pursued by others before like Xerox, Apple, so on, at the User
Interface level. The underlying base OS (File, Network, ... I/O and process
management) is largely copies of DEC VMS. Of course, the most senior engineer
on the NT project that defined the Win32 API was from DEC. Some will recall
litigation that Microsoft settled with DEC for finding large pieces of VMS code
on NT, down to complete data structures !!!

Onto the current UNIX field. Every single UNIX OS in the market has major flaws
if compared to the other. AIX thread performance sucks (said by IBM employees
openly to me). Solaris file system I/O sucks compared to AIX, at least until
Veritas came around, I don't fell competent to coment Veritas fs. HP-UX memory
management for caching seems infantile compared to AIX's. AIX beats the other
OS's on not needing so much kernel linking or boot time parameter setting.

All of this happens because of scarse resources. If you look at the OS's from a
very technical level, I say Linux 2.5,72 has the best of all of them, because
the combined manpower available to Linux kernel development, combined with
basicly no deadlines, and complete willingness to redo what sucks without budget
(time) constraints, explains it.

Just the fact that all the source is open, makes the OS so much more valuable
to mission critical systems. In the rare situation someone finds a bug in Linux
after a system is deployed, the fix is usually available very kickly, and the
user can apply only the fix to his problem to his production system, avoiding
service packs that fix hundreds of bugs at the same time, which usually leads
to other bugs. If M$'s bug database and their code was 100% available to
everybody,  it would be very, very, very enlightning to see how much even XP
sucks internally.

The fact that Linux development is not affected by trade show dates or revenue
expectations plus peer review is what makes it's development process so much
more reliable.

In time, I'm sure funding for Linux will happen. I think it's only a matter of
time until some way in which people that make important contributions to Linux
will be paid for that, perhaps by the way of a Linux foundation, that would
collect donations from heavvy Linux users (dreaming right now). If IBM makes
a billion/year from Linux, what's it donating 10 million a Year to such a 
foundation, which would be enough to keep maybe 200 developers paid for what
they're doing. My fear is such system might spoil some of the spirit in which
people contribute to Linux.

Pooling 10 million a year to reward Linux kernel contributors would be actually
a lot cheaper even if it came from a single UNIX vendor alone, look at how many
members OSDL has !!! Combined, they could contribute 10 million a year, at an
almost pocket change sum for each company individually.
