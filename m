Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbTD1RDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbTD1RDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:03:30 -0400
Received: from ns.suse.de ([213.95.15.193]:1544 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261197AbTD1RD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:03:29 -0400
Date: Mon, 28 Apr 2003 19:14:55 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428171455.GC1068@Wotan.suse.de>
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAD5AC1.7090003@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 09:45:53AM -0700, Dave Hansen wrote:
> Andi Kleen wrote:
> > Realistic limit currently is ~16GB with an IA32 box.  For more you need
> > an 64bit architecture.
> 
> Let's say 32GB :)  It boots just fine with 2.5.68, no additional
> patches.  There's even half a gig of lowmem free.

But what happens when you stress test it? No deadlocks?

-Andi
