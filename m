Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUBYTSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbUBYTR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:17:27 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:56585 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261584AbUBYTQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:16:35 -0500
Date: Wed, 25 Feb 2004 14:16:33 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0402240922280.430603-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0402251410240.493062-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Feb 2004, Ron Peterson wrote:

> I've also added some graphs of must monitoring mist (which is the machine
> I actually care about the most right now).  Mist ping latencies are
> predictably on the upswing again.  I'll likely be rebooting soon.
> 
> http://depot.mtholyoke.edu:8080/tmp/must-mist/2002-02-24_8:40/

I've had to turn my attention to some other responsibilities, so I haven't
done any kernel profiling yet.  However, I can report that I rebooted
'mist' into 2.4.20 yesterday, and I have seen rock solid .15 ms response
times for more than 24 hours.  Host 'must' is likewise now stable, running
2.4.20 for two days now.  I have graphs, logs, etc. if anyone cares to see
them.

mist is hyperthreaded dual xeon now back to built-in broadcom adapter (tg3
module).  must is single cpu asus p4pe w/ 3com adapter.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

