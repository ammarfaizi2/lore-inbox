Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbULJStB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbULJStB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbULJStB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:49:01 -0500
Received: from fsmlabs.com ([168.103.115.128]:25997 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261798AbULJSs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:48:58 -0500
Date: Fri, 10 Dec 2004 11:48:39 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Stephen Degler <stephen@degler.net>
cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: NUMA on i386 with Opterons
In-Reply-To: <43220.166.84.149.254.1102702048.squirrel@crusoe.degler.net>
Message-ID: <Pine.LNX.4.61.0412101147310.5971@montezuma.fsmlabs.com>
References: <43220.166.84.149.254.1102702048.squirrel@crusoe.degler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, Stephen Degler wrote:

> Should i386 NUMA be working on with Opteron systems?  I'm blowing up
> on various Tyan motherboards.  Of course x86_64 kernels run fine.
> 
> Any insight you could provide would be welcome.  The same error occurs
> with vanilla 2.6.10-rc3.

As far as i know it isn't supported. The NUMA option on i386 is for larger 
non opteron systems.
