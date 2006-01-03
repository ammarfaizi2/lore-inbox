Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWACW3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWACW3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWACW3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:29:21 -0500
Received: from xenotime.net ([66.160.160.81]:35815 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751488AbWACW3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:29:20 -0500
Date: Tue, 3 Jan 2006 14:29:16 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: sushant@cs.unm.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: Benchmarks
Message-ID: <Pine.LNX.4.58.0601031426290.16308@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| Hello everyone,
| If someone make some modifications to kernel code and want to know how much
| overead those modifications has caused, what are the benchmarks that one
| should use to calculate the overhead of the added code.
| please cc the reply to me.
| Thanks a lot.

There are a lot of benchmarks out there.
E.g., some are listed at
  http://lbs.sourceforge.net/
and
  http://lse.sourceforge.net/benchmarks/

just depends on what you want/need, like others have said.
-- 
~Randy
