Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTICPgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263892AbTICPgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:36:09 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:18781 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263885AbTICPgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:36:05 -0400
Subject: Re: Scaling noise
From: Steven Cole <elenstev@mesatop.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: Larry McVoy <lm@bitmover.com>, CaT <cat@zip.com.au>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030903124716.GE2359@wind.cocodriloo.com>
References: <20030903040327.GA10257@work.bitmover.com>
	 <20030903041850.GA2978@krispykreme>
	 <20030903042953.GC10257@work.bitmover.com>
	 <20030903043355.GC2019@zip.com.au>
	 <20030903050859.GD10257@work.bitmover.com>
	 <1062599136.1724.84.camel@spc9.esa.lanl.gov>
	 <20030903124716.GE2359@wind.cocodriloo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062603063.1723.91.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 03 Sep 2003 09:31:04 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 06:47, Antonio Vargas wrote:
> On Wed, Sep 03, 2003 at 08:25:36AM -0600, Steven Cole wrote:
> > On Tue, 2003-09-02 at 23:08, Larry McVoy wrote:
> > > On Wed, Sep 03, 2003 at 02:33:56PM +1000, CaT wrote:
> 
> > [snip]
> > 
> > The question which will continue to be important in the next kernel
> > series is: How to best accommodate the future many-CPU machines without
> > sacrificing performance on the low-end?  The change is that the 'many'
> > in the above may start to double every few years.
> > 
> > Some candidate answers to this have been discussed before, such as
> > cache-coherent clusters.  I just hope this gets worked out before the
> > hardware ships.
> 
> As you may probably know, CC-clusters were heavily advocated by the
> same Larry McVoy who has started this thread.
> 

Yes, thanks.  I'm well aware of that.  I would like to get a discussion
going again on CC-clusters, since that seems to be a way out of the
scaling spiral.  Here is an interesting link:
http://www.opersys.com/adeos/practical-smp-clusters/

Steven



