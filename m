Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751891AbWB1R0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWB1R0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWB1R0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:26:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29980 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932221AbWB1R0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:26:40 -0500
Date: Tue, 28 Feb 2006 18:25:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Fixup ahci suspend / resume
Message-ID: <20060228172542.GF24981@suse.de>
References: <44045FB1.5040408@suse.de> <440468DB.5060605@pobox.com> <20060228151928.GC24981@suse.de> <44046AC2.1060002@pobox.com> <20060228152847.GE24981@suse.de> <44046DC3.4060508@pobox.com> <440472F6.6090905@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440472F6.6090905@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28 2006, Hannes Reinecke wrote:
> Jeff Garzik wrote:
> > Jens Axboe wrote:
> >> I'm sure Hannes will regenerate against upstream as well if necessary,
> >> however that depends on when this should be applied.
> > 
> > It's far too late and too intrusive for 2.6.16-rc.
> > 
> > It's #upstream or <null>.
> > 
> Calm down. Of course I will regenerate is against #upstream.
> In fact, I've done so initially but wasn't sure what the status of
> libata-dev is. So I've diffed it against linux-git instead.
> 
> Updated patch to follow.

Thanks Hannes. I wasn't so much worried about it going directly in (I
have no problem waiting), just that there seemed to be some disagreement
on where suspend is at and what we can "support".

-- 
Jens Axboe

