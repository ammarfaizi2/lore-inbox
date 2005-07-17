Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVGQDYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVGQDYW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 23:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGQDYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 23:24:21 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:5612 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261805AbVGQDYU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 23:24:20 -0400
X-ORBL: [63.202.173.158]
Date: Sat, 16 Jul 2005 20:24:07 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050717032407.GA29404@taniwha.stupidest.org>
References: <20050706001333.GA3569@sysman-doug.us.dell.com> <20050706005320.GA23709@taniwha.stupidest.org> <20050712231729.GA15062@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712231729.GA15062@sysman-doug.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 06:17:29PM -0500, Doug Warzecha wrote:

> Because the hardware interfaces on those systems and the Dell
> systems management software that access the interfaces are
> proprietary, I can't provide specifications for the interfaces or
> source code for the software.

So you want a driver merged which nobody except Dell can write code
for?

> The systems that are supported by the dcdbas driver contain the
> following Dell proprietary hardware systems management interfaces:
> Temperature Voltage Monitor (TVM) and Calling Interface.  These
> interfaces are supported by older Dell PowerEdge systems.

What's so special here that you can't give more details?  I personally
find it a little unfair to ask to have a driver merged into mainline
to facilitate some proprietary userland where you refuse to give
protocol level details to create a viable alternative.

