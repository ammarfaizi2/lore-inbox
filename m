Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbULKReI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbULKReI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbULKReH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:34:07 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:46764 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261978AbULKRdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:33:54 -0500
Subject: Re: [BK PATCH] SCSI -rc fixes for 2.6.10-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041211172202.GD3033@suse.de>
References: <1102650988.3814.13.camel@mulgrave>
	 <20041210201115.GD12581@suse.de> <41BA2948.4030906@osdl.org>
	 <1102776407.5688.4.camel@mulgrave>  <20041211172202.GD3033@suse.de>
Content-Type: text/plain
Organization: SteelEye Technology, inc.
Date: Sat, 11 Dec 2004 11:33:32 -0600
Message-Id: <1102786412.5688.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-11 at 18:22 +0100, Jens Axboe wrote:
> Yep, that would be the optimal. But still, given the hardware, I feel
> the hacky workaround would be acceptable. If Randy wants to fix it
> properly being able to test it, perfect.

Actually, I already put your patch in the scsi-rc-fixes-2.6 tree since
it was obviously correct.  I was just being hopeful ...

James


