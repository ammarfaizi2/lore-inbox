Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTICPRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTICPRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:17:24 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:13038
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S263467AbTICPRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:17:20 -0400
Date: Wed, 3 Sep 2003 14:47:16 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Larry McVoy <lm@bitmover.com>, CaT <cat@zip.com.au>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903124716.GE2359@wind.cocodriloo.com>
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903043355.GC2019@zip.com.au> <20030903050859.GD10257@work.bitmover.com> <1062599136.1724.84.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062599136.1724.84.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:25:36AM -0600, Steven Cole wrote:
> On Tue, 2003-09-02 at 23:08, Larry McVoy wrote:
> > On Wed, Sep 03, 2003 at 02:33:56PM +1000, CaT wrote:

> [snip]
> 
> The question which will continue to be important in the next kernel
> series is: How to best accommodate the future many-CPU machines without
> sacrificing performance on the low-end?  The change is that the 'many'
> in the above may start to double every few years.
> 
> Some candidate answers to this have been discussed before, such as
> cache-coherent clusters.  I just hope this gets worked out before the
> hardware ships.

As you may probably know, CC-clusters were heavily advocated by the
same Larry McVoy who has started this thread.

Greets, Antonio.
