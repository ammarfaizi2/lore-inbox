Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVFTJiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFTJiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 05:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVFTJiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 05:38:07 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:13447 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261294AbVFTJhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 05:37:46 -0400
Subject: Re: [GIT PATCH] SCSI updates for 2.6.12
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050618174558.GX9153@shell0.pdx.osdl.net>
References: <1119103586.4984.5.camel@mulgrave>
	 <20050618141636.GA4112@infradead.org>
	 <20050618174558.GX9153@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 11:35:40 +0200
Message-Id: <1119260140.6099.0.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-18 at 10:45 -0700, Chris Wright wrote:
> Sure, if it's seriously broken w/out send it to stable@kernel.org,
> and we'll queue it up.

It should be here:

rsync://www.parisc-linux.org/~jejb/git/scsi-rc-fixes-2.6.git

That's the same patch that's merged now.

James


