Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVDEOzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVDEOzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVDEOya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:54:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64222 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261773AbVDEOyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:54:24 -0400
Date: Tue, 5 Apr 2005 16:54:17 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] new fifo I/O elevator that really does nothing at all
Message-ID: <20050405145416.GT15165@suse.de>
References: <20050329200408.GZ16636@suse.de> <200503292007.j2TK7cg01419@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503292007.j2TK7cg01419@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29 2005, Chen, Kenneth W wrote:
> Jens Axboe wrote on Tuesday, March 29, 2005 12:04 PM
> > No such promise was ever made, noop just means it does 'basically
> > nothing'. It never meant FIFO in anyway, we cannot break the semantics
> > of block layer commands just for the hell of it.
> 
> Acknowledged and understood, will try your patch shortly.

Did you test it?

-- 
Jens Axboe

