Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbUKXMS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbUKXMS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 07:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUKXMS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 07:18:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63673 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262555AbUKXMSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 07:18:25 -0500
Date: Wed, 24 Nov 2004 05:08:21 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28 -> ch..ch...changes....
Message-ID: <20041124070821.GA8718@logos.cnet>
References: <200411232136.36313.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411232136.36313.nick@linicks.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 09:36:36PM +0000, Nick Warne wrote:
> Hi Guys,
> 
> I updated three boxes today to 2.4.28 (from .27), one at work, and two here at 
> home (Redhat 7.1+, Slackware 10)
> 
> I am intrigued terribly by the small footprint of memory usage now.  I have 
> gone through the changes file, but can really see nothing (to me, a n00b) 
> that would alter that?
> 
> Can anyone enlighten me?

What do you mean by "memory usage"? SLAB (/proc/slabinfo) buffers
or pagecache ?

Whats your workload and what drivers are you using ?

Nothing that I am aware of explains this.
