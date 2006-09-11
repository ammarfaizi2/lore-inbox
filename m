Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWIKTxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWIKTxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWIKTxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:53:13 -0400
Received: from brick.kernel.dk ([62.242.22.158]:46187 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751359AbWIKTxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:53:11 -0400
Date: Mon, 11 Sep 2006 21:51:28 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
Message-ID: <20060911195128.GB6775@kernel.dk>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <1157986974.23085.147.camel@localhost.localdomain> <45057651.8000404@garzik.org> <1157988513.23085.159.camel@localhost.localdomain> <20060911153706.GE4955@suse.de> <1157991998.23085.164.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157991998.23085.164.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11 2006, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 17:37 +0200, ysgrifennodd Jens Axboe:
> > On Mon, Sep 11 2006, Alan Cox wrote:
> > > sometimes. The IBM's abort the xfer but the maxtors may or may not get
> > > it right (its as if half the firmware has the right test).
> > 
> > So this is a confirmed, broken case? Why has no one complained for 2.4
> > and 2.6?
> 
> They did and proposed patches.

Link?

-- 
Jens Axboe

