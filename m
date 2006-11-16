Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031156AbWKPLLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031156AbWKPLLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 06:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031157AbWKPLLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 06:11:15 -0500
Received: from ns1.suse.de ([195.135.220.2]:52902 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031156AbWKPLLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 06:11:14 -0500
From: Andi Kleen <ak@suse.de>
To: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH] mempolicy: use vma_policy and vma_set_policy macros
Date: Thu, 16 Nov 2006 12:11:09 +0100
User-Agent: KMail/1.9.5
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64N.0611160253510.3429@attu4.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0611160253510.3429@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161211.09445.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 12:00, David Rientjes wrote:
> Use vma_policy() and vma_set_policy() macros provided in 
> include/linux/mempolicy.h.

Why? I don't think it makes the code any more readable

-Andi

