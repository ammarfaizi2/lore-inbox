Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272501AbTGaPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272524AbTGaPX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:23:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10451 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S272538AbTGaPWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:22:30 -0400
Date: Thu, 31 Jul 2003 17:22:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Miller, Mike (OS Dev)" <mike.miller@hp.com>,
       "Marcelo Tosatti (E-mail)" <marcelo@conectiva.com.br>,
       "Lkml (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: cciss updates for 2.4.22
Message-ID: <20030731152221.GE22104@suse.de>
References: <D4CFB69C345C394284E4B78B876C1CF104052AC9@cceexc23.americas.cpqcorp.net> <3F292478.6040504@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F292478.6040504@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31 2003, Jeff Garzik wrote:
> Miller, Mike (OS Dev) wrote:
> >The attached tarball contains 2 patches. The first is an author change for 
> >the cciss driver. The second resolves an issue when sharing IRQs with 
> >another controller. The patches have been built & tested against 
> >2.4.22-pre9. They can be installed in any order.
> >More to come.
> 
> 
> Mike, you should consider sending one-patch-per-email.  This makes it 
> much easier for Marcelo to use standard scripts to quickly and easily 
> apply your patches.

Agree on that, a tar'ed collection of patches is hard to easily review.
Mike, try attaching them next time. I know your mailer eats inlines, but
attachments ought to work fine.

-- 
Jens Axboe

