Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUHEPCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUHEPCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUHEPCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:02:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57229 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267747AbUHEPCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:02:47 -0400
Date: Thu, 5 Aug 2004 17:02:05 +0200
From: Jens Axboe <axboe@suse.de>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: cciss update [1 of 6]
Message-ID: <20040805150205.GG12483@suse.de>
References: <D4CFB69C345C394284E4B78B876C1CF107DBFBA7@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107DBFBA7@cceexc23.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Miller, Mike (OS Dev) wrote:
> Sorry, I thought the descriptions in the patch were sufficient.
> Again, I wish viro would copy me on patches to cciss. Isn't that the
> normal protocol, include the maintainer in any updates?

(Mike, please don't top post...)

People usually try to do that, for some bigger patch sets that touch
lots of files (which Al does do a lot of), it's not always easy to do
so. I suggest you try and track at least each major release and see what
has been applied to your driver (if anything). That way you also don't
risk backing out included fixes when diffing your own tree.

-- 
Jens Axboe

