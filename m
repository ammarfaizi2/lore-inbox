Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUDSUzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUDSUzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbUDSUzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:55:51 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:37510 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261832AbUDSUzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:55:50 -0400
Date: Tue, 20 Apr 2004 00:55:45 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, rth@twiddle.net
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (alpha)
Message-ID: <20040420005545.A680@den.park.msu.ru>
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk> <E1BFYhQ-00055j-CL@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1BFYhQ-00055j-CL@dyn-67.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Apr 19, 2004 at 02:20:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 02:20:36PM +0100, Russell King wrote:
> This patch cleans up needless includes of asm/pgalloc.h from the
> arch/alpha/ subtree.  This has not been compile tested, so
> needs the architecture maintainers (or willing volunteers) to
> test.

This compiles cleanly. Thanks.

Ivan.
