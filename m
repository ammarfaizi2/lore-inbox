Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUEBGjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUEBGjv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUEBGju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:39:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:32148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261648AbUEBGjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:39:41 -0400
Date: Sat, 1 May 2004 23:38:42 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-parport@torque.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6-rc1] RFT add class support to drivers/block/paride/pg.c
Message-ID: <20040502063842.GC3766@kroah.com>
References: <40530000.1082588088@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40530000.1082588088@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 03:54:48PM -0700, Hanna Linder wrote:
> 
> This patch adds class support to pg.c, the parallel port generic ATAPI device driver.
> 
> I have verified it compiles but do not have the hardware. If someone does and
> could test that would be helpful.

Applied, thanks.

greg k-h
