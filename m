Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTBXQVO>; Mon, 24 Feb 2003 11:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbTBXQVN>; Mon, 24 Feb 2003 11:21:13 -0500
Received: from bitmover.com ([192.132.92.2]:50641 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267357AbTBXQVM>;
	Mon, 24 Feb 2003 11:21:12 -0500
Date: Mon, 24 Feb 2003 08:31:19 -0800
From: Larry McVoy <lm@bitmover.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Larry McVoy <lm@bitmover.com>, William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224163119.GD5665@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Benjamin LaHaise <bcrl@redhat.com>, Larry McVoy <lm@bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com> <20030224154725.GB5665@work.bitmover.com> <20030224112314.H15376@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224112314.H15376@redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 11:23:14AM -0500, Benjamin LaHaise wrote:
> kernel for specific applications.  I'm curious if there is a collection 
> of lmbench results of hand configured and compiled kernels vs the vendor 
> module based kernels across 2.0, 2.2, 2.4 and recent 2.5 on the same 
> uniprocessor and dual processor configuration.  

If someone were willing to build the init script infra structure to 
reboot to a new kernel, run the test, etc., I'll buy a couple of 
machines and just let them run through this.  I'd like to do it 
with the cache miss counters turned on so if P4's do a nicer job
of counting than Athlons, I'll get those.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
