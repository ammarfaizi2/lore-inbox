Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUCLUjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUCLUhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:37:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6855 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262613AbUCLUco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:32:44 -0500
Date: Fri, 12 Mar 2004 15:32:20 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312202741.GG30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403121532060.6494-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Andrea Arcangeli wrote:

> 7.5k users are being reached in a real workload with around 2gigs mapped
> per process and with tons of vma per process. with 2.6 and faster cpus
> I hope to go even further.

That's not all anonymous memory, though ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

