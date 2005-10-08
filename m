Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVJHWrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVJHWrH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 18:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJHWrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 18:47:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:8064 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932187AbVJHWrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 18:47:06 -0400
X-Authenticated: #20450766
Date: Sun, 9 Oct 2005 00:37:47 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m3k6gw86f0.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0510090035450.16544@poirot.grange>
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange> <m3slvtzf72.fsf@telia.com>
 <Pine.LNX.4.60.0509252026290.3089@poirot.grange> <m34q873ccc.fsf@telia.com>
 <Pine.LNX.4.60.0509262122450.4031@poirot.grange> <m3slvr1ugx.fsf@telia.com>
 <Pine.LNX.4.60.0509262358020.6722@poirot.grange> <m3hdc4ucrt.fsf@telia.com>
 <Pine.LNX.4.60.0509292116260.11615@poirot.grange> <m3k6gw86f0.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005, Peter Osterlund wrote:

> OK, in that case this patch for 2.6.12 should work as well, because
> all it does compared to the previous patch is to remove the now unused
> high_prio_read variables. Can you confirm that it works?

Sorry, Peter, was away for a week. Just came back late today, will re-test 
asap and report back.

Regards
Guennadi
---
Guennadi Liakhovetski
