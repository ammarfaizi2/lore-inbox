Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTICEea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 00:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTICEea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 00:34:30 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:30347 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S262273AbTICEe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 00:34:29 -0400
Date: Wed, 3 Sep 2003 14:33:56 +1000
From: CaT <cat@zip.com.au>
To: Larry McVoy <lm@work.bitmover.com>, Anton Blanchard <anton@samba.org>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903043355.GC2019@zip.com.au>
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903042953.GC10257@work.bitmover.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 09:29:53PM -0700, Larry McVoy wrote:
> On Wed, Sep 03, 2003 at 02:18:51PM +1000, Anton Blanchard wrote:
> > > I've frequently tried to make the point that all the scaling for lots of
> > > processors is nonsense.  Mr Dell says it better:
> > > 
> > >     "Eight-way (servers) are less than 1 percent of the market and shrinking
> > >     pretty dramatically," Dell said. "If our competitors want to claim
> > >     they're No. 1 in eight-ways, that's fine. We want to lead the market
> > >     with two-way and four-way (processor machines)."
> > > 
> > > Tell me again that it is a good idea to screw up uniprocessor performance
> > > for 64 way machines.  Great idea, that.  Go Dinosaurs!
> > 
> > And does your 4 way have hyperthreading?
> 
> What part of "shrinking pretty dramatically" did you not understand?  Maybe
> you know more than Mike Dell.  Could you share that insight?

I think Anton is referring to the fact that on a 4-way cpu machine with
HT enabled you basically have an 8-way smp box (with special conditions)
and so if 4-way machines are becoming more popular, making sure that 8-way
smp works well is a good idea.

At least that's how I took it.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
