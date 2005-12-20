Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVLTP47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVLTP47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVLTP47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:56:59 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:39896 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751105AbVLTP46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:56:58 -0500
Subject: Re: [PATCH RT 00/02] SLOB optimizations
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1135093460.13138.302.camel@localhost.localdomain>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
	 <1135093460.13138.302.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 10:56:36 -0500
Message-Id: <1135094196.13138.306.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 10:44 -0500, Steven Rostedt wrote:
> (Andrew, I'm CC'ing you and Matt to see if you would like this in -mm)
> 
> OK Ingo, here it is.

I just tested it out on SMP (2x), and it boots. Ingo, do you have a good
memory test that I can do benchmarks with?  Something better that my
"make install" test.

Thanks,

-- Steve


