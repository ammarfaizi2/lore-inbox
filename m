Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUBVGmR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUBVGmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:42:17 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:59008 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261181AbUBVGmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:42:17 -0500
Date: Sat, 21 Feb 2004 22:42:16 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Run cpuid.c and msr.c through Lindent
Message-ID: <20040222064216.GA15101@dingdong.cryptoapps.com>
References: <4037F4E0.6050508@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4037F4E0.6050508@quark.didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 07:16:32PM -0500, Brian Gerst wrote:

> Run cpuid.c and msr.c through Lindent to improve readability.  The
> only non-whitespace change was to add a missing semicolon after
> module_exit().

As much as I had poor/inconsistent formatting, gratuitous whitespace
changes are really annoying when you have to deal with merging code
across several kernel versions (as I have had to do) and I really
prefer to see these things done as the code is fixed/modified.



  --cw

