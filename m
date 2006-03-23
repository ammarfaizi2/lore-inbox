Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWCWHEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWCWHEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 02:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWCWHEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 02:04:04 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:45241 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932465AbWCWHED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 02:04:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: swap prefetching merge plans
Date: Thu, 23 Mar 2006 18:04:36 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <20060322205305.0604f49b.akpm@osdl.org>
In-Reply-To: <20060322205305.0604f49b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231804.36334.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> A look at the -mm lineup for 2.6.17:

> mm-implement-swap-prefetching.patch
> mm-implement-swap-prefetching-fix.patch
> mm-implement-swap-prefetching-tweaks.patch

>   Still don't have a compelling argument for this, IMO.

For those users who feel they do have a compelling argument for it, please 
speak now or I'll end up maintaining this in -ck only forever.  I've come to 
depend on it with my workloads now so I'm never dropping it. There's no point 
me explaining how it is useful yet again, though, because I just end up 
looking like I'm handwaving. It seems a shame for it not to be available to 
all linux users.

Cheers,
Con
