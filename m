Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUEBGjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUEBGjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUEBGjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:39:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:28564 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261505AbUEBGjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:39:37 -0400
Date: Sat, 1 May 2004 23:39:08 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, grant@torque.net
Subject: Re: [PATCH 2.6.5 RFT] add class support to drivers/block/paride/pt.c
Message-ID: <20040502063908.GD3766@kroah.com>
References: <451930000.1082486164@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451930000.1082486164@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 11:36:04AM -0700, Hanna Linder wrote:
> 
> Hi,
> 
> This patch adds class support to pt.c which "the high-level driver for
> parallel port ATAPI tape drives based on chips supported by the paride
> module." Which I dont have in order to test.
> 
> I have verified it compiles but can not test it. If someone who has
> the hardware could I would appreciate it.

Applied, thanks.

greg k-h
