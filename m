Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWHaRkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWHaRkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWHaRkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:40:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27341 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932403AbWHaRkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:40:01 -0400
Date: Thu, 31 Aug 2006 10:39:58 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH 4/9] ia64 generic PAGE_SIZE
In-Reply-To: <1157045910.31295.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608311039260.12416@schroedinger.engr.sgi.com>
References: <20060830221604.E7320C0F@localhost.localdomain> 
 <20060830221607.1DB81421@localhost.localdomain> 
 <Pine.LNX.4.64.0608301652270.5789@schroedinger.engr.sgi.com>
 <1157045910.31295.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006, Dave Hansen wrote:

> > #define KERNEL_STACK_SIZE_ORDER (max(0, 15 - PAGE_SHIFT)) 
> 
> My next series will be to clean up stack size handling.  Do you mind if
> it waits until then?

I am not in a hurry on this one.


