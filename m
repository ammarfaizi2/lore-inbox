Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbULTQ5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbULTQ5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbULTQ5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:57:31 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:11695 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261569AbULTQ5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:57:21 -0500
Date: Mon, 20 Dec 2004 10:56:29 -0600
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, Andi Kleen <ak@suse.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041220165629.GA21231@rx8.austin.ibm.com>
References: <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com> <50260000.1103061628@flay> <20041215045855.GH27225@wotan.suse.de> <20041215144730.GC24000@krispykreme.ozlabs.ibm.com> <20041216050248.GG32718@wotan.suse.de> <20041216051323.GI24000@krispykreme.ozlabs.ibm.com> <20041216141814.GA10292@rx8.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216141814.GA10292@rx8.austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose R. Santos <jrsantos@austin.ibm.com> [041216]:
> I can do the SpecSFS runs but each runs takes several hours to complete
> and I would need to do two runs (baseline and patched).  I may have it 
> ready by today or tommorow.

The difference between the two runs was with in noise of the benchmark on
my small setup.  I wont be able to get a larger NUMA system until next year,
so I'll retest when that happens.  In the mean time, I don't see a reason
either to stall this patch, but that may change on I get numbers on a
larger system.

-JRS
