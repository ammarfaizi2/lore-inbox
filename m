Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424262AbWKPQTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424262AbWKPQTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424263AbWKPQTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:19:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34954 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1424262AbWKPQTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:19:06 -0500
Date: Thu, 16 Nov 2006 08:18:56 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: David Rientjes <rientjes@cs.washington.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mempolicy: use vma_policy and vma_set_policy macros
In-Reply-To: <200611161211.09445.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0611160818450.27796@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64N.0611160253510.3429@attu4.cs.washington.edu>
 <200611161211.09445.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006, Andi Kleen wrote:

> On Thursday 16 November 2006 12:00, David Rientjes wrote:
> > Use vma_policy() and vma_set_policy() macros provided in 
> > include/linux/mempolicy.h.
> 
> Why? I don't think it makes the code any more readable

I agree. Lets leave it as it is.

