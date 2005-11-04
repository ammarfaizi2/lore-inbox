Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbVKDGLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbVKDGLD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbVKDGLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:11:02 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51663 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161077AbVKDGLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:11:01 -0500
Date: Thu, 3 Nov 2005 22:10:37 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: andy@thermo.lanl.gov, mbligh@mbligh.org, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       mingo@elte.hu, nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051103221037.33ae0f53.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov>
	<Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> Maybe you'd be willing on compromising by using a few kernel boot-time 
> command line options for your not-very-common load.

If we were only a few options away from running Andy's varying load
mix with something close to ideal performance, we'd be in fat city,
and Andy would never have been driven to write that rant.

There's more to it than that, but it is not as impossible as a battery
with the efficiencies you (and the rest of us) dream of.

Andy has used systems that resemble what he is seeking.  So he is not
asking for something clearly impossible.  Though it might not yet be
possible, in ways that contribute to a continuing healthy kernel code
base.

It's an interesting challenge - finding ways to improve the kernel's
performance on such high end loads, that are also suitable and
desirable (or at least innocent enough) for inclusion in a kernel far
more widely used in embeddeds, desktops and ordinary servers.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
