Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266416AbUBFE23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUBFE23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:28:29 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15800
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266416AbUBFE2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:28:17 -0500
Date: Fri, 6 Feb 2004 05:28:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andi Kleen <ak@suse.de>,
       johnstul@us.ibm.com, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040206042815.GO31926@dualathlon.random>
References: <20040205214348.GK31926@dualathlon.random> <Pine.LNX.4.44.0402052314360.5933-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402052314360.5933-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 11:15:00PM -0500, Rik van Riel wrote:
> On Thu, 5 Feb 2004, Andrea Arcangeli wrote:
> 
> > However I'm unsure if you want all applications to be relocated
> > ranodmly, and in turn if you want the vsyscalls relocated for all apps,
> > exactly because this carry a cost. I think it should be optional.
> 
> If you think extra security should be optional, please don't
> argue against it completely.

I don't think I was arguing against it completely, exactly because I'm
just saying it should be optional.
