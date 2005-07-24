Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVGXOYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVGXOYU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 10:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVGXOYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 10:24:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64200 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261211AbVGXOX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 10:23:56 -0400
Date: Sun, 24 Jul 2005 16:23:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Amit S. Kale" <amitkale@linsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CheckFS: Checkpoints and Block Level Incremental Backup (BLIB)
Message-ID: <20050724142352.GB1778@elf.ucw.cz>
References: <200507231130.07208.amitkale@linsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507231130.07208.amitkale@linsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Thanks for your suggestions and help.
> 
> We started it from 2.6.7 last year and then it was sitting idle for several 
> months for lack of resources. We'll go back to that version and generate a 
> diff that's easier to read.
> 
> Yes, changing the name has made the task of rebasing wrt. changing kernels lot 
> difficult. Our original intention was to make testing easier by keeping ext3 
> and checkfs filesystems in the same kernel. Had we continued it at that 
> point, we would have posted differences wrt. ext3 sources themselves. There 
> was compelling reason to change the name.

Maybe you want to put your development machines on ext*2* while doing
this ;-). Or perhaps reiserfs/xfs/something.
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
