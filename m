Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264432AbUFDKIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbUFDKIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 06:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbUFDKIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 06:08:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3472 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264432AbUFDKIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 06:08:15 -0400
Date: Fri, 4 Jun 2004 12:08:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Rick Jansen <rick@rockingstone.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DriveReady SeekComplete Error
Message-ID: <20040604100813.GP1946@suse.de>
References: <20040604075448.GK18885@web1.rockingstone.nl> <200406040943.i549h2aG000175@81-2-122-30.bradfords.org.uk> <20040604095409.GL18885@web1.rockingstone.nl> <20040604095900.GO1946@suse.de> <20040604100258.GM18885@web1.rockingstone.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604100258.GM18885@web1.rockingstone.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't trim people from the cc list, thanks)

On Fri, Jun 04 2004, Rick Jansen wrote:
> On Fri, Jun 04, 2004 at 11:59:00AM +0200, Jens Axboe wrote:
> > 
> > It is, what kernel are you using?
> > 
> > -- 
> > Jens Axboe
> 
> This is 2.6.6.

The that's a known error, you should not worry about it. It's fixed in
later kernels.

-- 
Jens Axboe

