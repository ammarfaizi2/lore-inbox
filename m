Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275239AbTHRXLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 19:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275240AbTHRXLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 19:11:48 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64526 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S275239AbTHRXLr
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 19:11:47 -0400
Date: Mon, 18 Aug 2003 19:03:30 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rob Landley <rob@landley.net>
cc: Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
In-Reply-To: <200308170539.45145.rob@landley.net>
Message-ID: <Pine.LNX.3.96.1030818185635.2625F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003, Rob Landley wrote:

> On Wednesday 13 August 2003 17:06, Bill Davidsen wrote:
> 
> > It would be nice if there were some neat 3-D shreadsheet type thing
> > listing all drivers, all architectures, UP vs. SMP, and a status such as
> > WORKS, DOESN'T COMPILE, REPORTED PROBLEMS (SLOW|ERRORS|PANICS) and the
> > like. I don't even know where to find a good open source 3-D spreadsheet,
> > and the data certainly is scattered enough to be a project in itself,
> > chasing a moving target.
> 
> You are aware that this would probably take more effort to keep up to date 
> than the code itself, right?  And that one spreadsheet couldn't 
> simultaneously be accurate for 2.4, 2.6, -ac, -mm, -redhat, -suse...

Did you miss the "It would be nice" and "a project in itself?" I am aware
of the issues, I was hoping someone would tell me that there was a tool
which did all this already (bugkeeper?) or suggest some path to a useful
subset with a manageable resource cost. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

