Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbUCDTOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 14:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUCDTOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 14:14:14 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:36249 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262082AbUCDTOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 14:14:11 -0500
Subject: Re: [ANNOUNCE] kpatchup 0.02 kernel patching script
From: Dave Hansen <haveblue@us.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040304190927.GQ3883@waste.org>
References: <20040303022444.GA3883@waste.org>
	 <1078420922.19701.1362.camel@nighthawk> <20040304183516.GN3883@waste.org>
	 <1078426209.19701.1382.camel@nighthawk>  <20040304190927.GQ3883@waste.org>
Content-Type: text/plain
Message-Id: <1078427641.1380.1.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 11:14:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-04 at 11:09, Matt Mackall wrote:
> I suppose I could add a 2.6-tip, which will return the greatest of
> 2.6, 2.6-pre, and 2.6-bk. Like this:
> 
> $ kpatchup -s 2.6-tip
> 2.6.4-rc2
> $ kpatchup -u 2.6-tip
> http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.4-rc2.bz2

That would at least keep me from mixing different tools like I am now. 
It's not too big of a deal.

-- dave

