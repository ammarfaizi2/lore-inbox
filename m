Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTBXQWU>; Mon, 24 Feb 2003 11:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267366AbTBXQWT>; Mon, 24 Feb 2003 11:22:19 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:29087 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S267365AbTBXQWO>;
	Mon, 24 Feb 2003 11:22:14 -0500
Date: Mon, 24 Feb 2003 09:25:33 -0700
From: yodaiken@fsmlabs.com
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Larry McVoy <lm@work.bitmover.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224092533.B11805@hq.fsmlabs.com>
References: <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com> <20030224154725.GB5665@work.bitmover.com> <20030224112314.H15376@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030224112314.H15376@redhat.com>; from bcrl@redhat.com on Mon, Feb 24, 2003 at 11:23:14AM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 11:23:14AM -0500, Benjamin LaHaise wrote:
> Good point.  However, we are in a position to compare test results of 
> older linux kernels against newer, and to recompile code out of the 
> kernel for specific applications.  I'm curious if there is a collection 
> of lmbench results of hand configured and compiled kernels vs the vendor 
> module based kernels across 2.0, 2.2, 2.4 and recent 2.5 on the same 
> uniprocessor and dual processor configuration.  That would really give 
> us a better idea of how a properly tuned kernel vs what people actually 
> use for support reasons is costing us, and if we're winning or losing.

It's interesting to me that the people supporting the scale up do not 
carefully do such benchmarks and indeed have a rather cavilier attitude
to testing and benchmarking: or perhaps they don't think it's worth 
publishing. 

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
www.fsmlabs.com  www.rtlinux.com
1+ 505 838 9109

