Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRDMXBS>; Fri, 13 Apr 2001 19:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132338AbRDMXA6>; Fri, 13 Apr 2001 19:00:58 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:3856 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132327AbRDMXAw>;
	Fri, 13 Apr 2001 19:00:52 -0400
Date: Sat, 14 Apr 2001 01:00:35 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: george anzinger <george@mvista.com>
Cc: Ben Greear <greearb@candelatech.com>, Bret Indrelee <bret@io.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
Message-ID: <20010414010035.C2290@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.21.0104122258060.7396-100000@fnord.io.com> <3AD69D7F.36B2BA87@candelatech.com> <3AD6BBDD.D5BA23EE@mvista.com> <20010413123612.A30971@pcep-jamie.cern.ch> <3AD72428.CBA4F2B7@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD72428.CBA4F2B7@mvista.com>; from george@mvista.com on Fri, Apr 13, 2001 at 09:07:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> If we are to do high-res-timers, I think we will always have to do some
> sort of a sort on insert.

Yes, that's called a priority queue...  (And you don't actually sort on
each insertion).

-- Jamie
