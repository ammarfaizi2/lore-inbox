Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVJJUsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVJJUsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 16:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJJUsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 16:48:52 -0400
Received: from pop.gmx.de ([213.165.64.20]:59796 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751221AbVJJUsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 16:48:51 -0400
X-Authenticated: #20450766
Date: Mon, 10 Oct 2005 22:48:04 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <Pine.LNX.4.60.0510101947040.6650@poirot.grange>
Message-ID: <Pine.LNX.4.60.0510102244320.2671@poirot.grange>
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange> <m3slvtzf72.fsf@telia.com>
 <Pine.LNX.4.60.0509252026290.3089@poirot.grange> <m34q873ccc.fsf@telia.com>
 <Pine.LNX.4.60.0509262122450.4031@poirot.grange> <m3slvr1ugx.fsf@telia.com>
 <Pine.LNX.4.60.0509262358020.6722@poirot.grange> <m3hdc4ucrt.fsf@telia.com>
 <Pine.LNX.4.60.0509292116260.11615@poirot.grange> <m3k6gw86f0.fsf@telia.com>
 <Pine.LNX.4.60.0510092304550.14767@poirot.grange> <m3psqewe30.fsf@telia.com>
 <Pine.LNX.4.60.0510101947040.6650@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2005, Guennadi Liakhovetski wrote:

> On Sun, 9 Oct 2005, Peter Osterlund wrote:
> 
> > In that case, this patch should also work. Does it?
> 
> Yes. 2.6.13 + this patch work for me.

Oops... Things are getting out of control here... A more extensive test of 
your patch produced the same error again... I'll redo tests with your 
previous patches more thoroughly... This will take some time though.

Thanks
Guennadi
---
Guennadi Liakhovetski
