Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTLRAWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 19:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTLRAWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 19:22:17 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:46720 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264880AbTLRAWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 19:22:16 -0500
Date: Wed, 17 Dec 2003 19:21:52 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Roger Luethi <rl@hellgate.ch>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       <wli@holomorphy.com>, <kernel@kolivas.org>,
       <chris@cvine.freeserve.co.uk>, <linux-kernel@vger.kernel.org>,
       <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <20031217214107.GA3650@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.44.0312171921180.12531-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, Roger Luethi wrote:
> On Wed, 17 Dec 2003 20:49:51 +0100, Roger Luethi wrote:
> > right now just to make sure. It's going to take a couple of hours,
> > I'll follow up with results.
> 
> For efax, a benchmark run with mem=32M, the difference in run time
> between values 256 and 1024 for /proc/sys/vm/min_free_kbytes is noise
> (< 1%).

OK, so I guess you're not as close to the knee
of the curve as this kind of tests tend to be ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

