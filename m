Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267947AbTBVXNn>; Sat, 22 Feb 2003 18:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267952AbTBVXNn>; Sat, 22 Feb 2003 18:13:43 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:35089 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267947AbTBVXNl>; Sat, 22 Feb 2003 18:13:41 -0500
Date: Sat, 22 Feb 2003 23:23:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222232349.A31768@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030222231552.GA31268@work.bitmover.com>; from lm@bitmover.com on Sat, Feb 22, 2003 at 03:15:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 03:15:52PM -0800, Larry McVoy wrote:
> Show me one OS which scales to 32 CPUs on an I/O load and run lmbench 
> on a single CPU.  Then take that same CPU and stuff it into a uniprocessor
> motherboard and run the same benchmarks on under Linux.  The Linux one
> will blow away the multi threaded one.  Come on, prove me wrong, show
> me the data.

I could ask the SGI Eagan folks to do that with an Altix and a IA64
Whitebox  - oh wait, both OSes would be Linux..

