Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFAChH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFAChH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 22:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVFAChH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 22:37:07 -0400
Received: from fsmlabs.com ([168.103.115.128]:11459 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261240AbVFAChB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 22:37:01 -0400
Date: Tue, 31 May 2005 20:38:30 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
Subject: Re: RT patch acceptance
In-Reply-To: <1117582887.4749.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0505312036410.23809@montezuma.fsmlabs.com>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk> 
 <1117556283.2569.26.camel@localhost.localdomain>  <20050531171143.GS5413@g5.random>
  <1117561379.2569.57.camel@localhost.localdomain>  <20050531175152.GT5413@g5.random>
  <1117564192.2569.83.camel@localhost.localdomain>  <20050531205424.GV5413@g5.random>
  <1117574551.5511.19.camel@localhost.localdomain>  <1117576067.23573.16.camel@mindpipe>
 <1117582887.4749.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005, Steven Rostedt wrote:

> On Tue, 2005-05-31 at 17:47 -0400, Lee Revell wrote:
> > On Tue, 2005-05-31 at 17:22 -0400, Steven Rostedt wrote:
> > > I wouldn't call RTAI, RTLinux or a nano-kernel (embedded with Linux)
> > > "Diamond" hard.  Maybe "Ruby" hard, but not diamond.  Remember, I use to
> > > test code that was running airplane engines, and none of those mentioned
> > > would qualify to run that.
> > 
> > I think trying to make these types of distinctions is a waste of time.
> > What matters is the MTBF of the software relative to the hardware on a
> > given system.  It would be stupid to use a commercial RTOS for a cell
> > phone because they fall apart in a year anyway and users don't seem to
> > care.  Ditto anything running on PC hardware.  For an airplane the MTBF
> > obviously must be more in line with that hardware which hopefully is way
> > more reliable.
> 
> Agreed.  I only brought up the stupid names just to show that there's
> not a black and white aspect to what RT is.  It's mainly a black art
> since there's no way to know how many bugs a program has, and how do you
> truly calculate the MTBF, other than running it on the hardware itself?

This discussion has digressed even further beyond hard/soft realtime 
to reliability and fault tolerance (airplane engine), which is not 
the same thing.
