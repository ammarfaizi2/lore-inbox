Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVI1GaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVI1GaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 02:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVI1GaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 02:30:22 -0400
Received: from vega.lnet.lut.fi ([157.24.109.150]:36872 "EHLO vega.lnet.lut.fi")
	by vger.kernel.org with ESMTP id S1751056AbVI1GaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 02:30:22 -0400
Date: Wed, 28 Sep 2005 09:30:17 +0300
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, alokk@calsoftinc.com
Subject: Re: 2.6.14-rc2 early boot OOPS (mm/slab.c:1767)
Message-ID: <20050928063017.GI1046@vega.lnet.lut.fi>
References: <20050927202858.GG1046@vega.lnet.lut.fi> <Pine.LNX.4.62.0509271630050.11040@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509271630050.11040@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
From: lapinlam@vega.lnet.lut.fi (Tomi Lapinlampi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 04:35:54PM -0700, Christoph Lameter wrote:
> On Tue, 27 Sep 2005, Tomi Lapinlampi wrote:
> 
> > I'm getting the following OOPS with 2.6.14-rc2 on an Alpha.
> 
> Hmmm. I am not familiar with Alpha. The .config looks as if this is a 
> uniprocessor configuration? No NUMA? 

This is a simple uniprocessor configuration, no NUMA, no SMP. 

> What is the value of MAX_NUMNODES?

I'm not familiar with NUMA, where can I check this (or does this question
even apply since it's not a NUMA system) ?

Plase keep me cc:'d,

Tomi

-- 
You can decide: live with free software or with only one evil company left?
