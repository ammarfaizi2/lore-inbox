Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbTCGGtk>; Fri, 7 Mar 2003 01:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbTCGGtk>; Fri, 7 Mar 2003 01:49:40 -0500
Received: from vitelus.com ([64.81.243.207]:53768 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S261392AbTCGGtj>;
	Fri, 7 Mar 2003 01:49:39 -0500
Date: Thu, 6 Mar 2003 23:00:05 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030307070005.GB21885@vitelus.com>
References: <20030307064552.GA21885@vitelus.com> <Pine.LNX.4.44.0303070748460.3794-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303070748460.3794-100000@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 07:50:59AM +0100, Ingo Molnar wrote:
> > [...] though I do experience my share of XMMS skips.
> 
> okay, could you please test BK-curr, or 2.5.64+combo-patch? Do the skips
> still persist? Did they get worse perhaps? I guess it might take a few
> days of music listening while doing normal desktop activity, to get a good
> feel of it though.

I was able to reproduce them by selecting text in Mathematica (ugh,
not a very helpful example). The skips were shorter and about three
times as hard to trigger as on 2.5.63.
