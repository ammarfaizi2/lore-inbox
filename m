Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264897AbSJRGg6>; Fri, 18 Oct 2002 02:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSJRGg6>; Fri, 18 Oct 2002 02:36:58 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:4241
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264897AbSJRGg5>; Fri, 18 Oct 2002 02:36:57 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Simon Roscic <simon.roscic@chello.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210171947.04255.simon.roscic@chello.at>
References: <200210152120.13666.simon.roscic@chello.at>
	 <200210161838.39824.simon.roscic@chello.at>
	 <1034824086.32333.29.camel@localhost>
	 <200210171947.04255.simon.roscic@chello.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034923374.10332.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 18 Oct 2002 01:42:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 12:47, Simon Roscic wrote:
> On Thursday 17 October 2002 05:08, GrandMasterLee <masterlee@digitalroadkill.net> wrote:
> > Do you actually get the lockups then?
> 
> no, i didn't had any lookups, each of the machines currently have an uptime 
> of only 16 day's and that's because we had to shutdown the power in our 
> whole company for a half day. 
> ...

One question about your config, are you using, on ANY machines,
QLA2300's or PCI-X, and 5.38.x or 6.xx qlogic drivers? If so, then
you've experienced no lockups with those machines too?


> if you are interested, procinfo -a shows this on one of the 3 machines:
> (all 3 are the same, except that the "primary" lotus domino server has 2 cpu's
> and 2 gb ram, the other 2, have 1 cpu and 1 gb ram)
> 
> ---------------- procinfo ----------------
> Linux 2.4.17-xfs-smp (root@adam-neu) (gcc 2.95.3 20010315 ) #1 2CPU [adam.]

Thanks for the info. I will hopefully have >5 days uptime now too. If
not, anyone need a Systems Architect? :-D

--The GrandMaster
