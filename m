Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273008AbTGaMPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 08:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272999AbTGaMPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 08:15:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:424 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S273008AbTGaMPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 08:15:38 -0400
Date: Thu, 31 Jul 2003 14:15:20 +0200
From: Jens Axboe <axboe@suse.de>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: "Marcelo Tosatti (E-mail)" <marcelo@conectiva.com.br>,
       "Lkml (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: cciss updates for 2.4.22
Message-ID: <20030731121520.GS22104@suse.de>
References: <D4CFB69C345C394284E4B78B876C1CF104052AC9@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF104052AC9@cceexc23.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30 2003, Miller, Mike (OS Dev) wrote:
> The attached tarball contains 2 patches. The first is an author change
> for the cciss driver. The second resolves an issue when sharing IRQs
> with another controller. The patches have been built & tested against
> 2.4.22-pre9. They can be installed in any order.

Don't feel bad for Charles, he never was the original author of the
driver anyways. So the label was misleading.

Marcelo, both patches look fine to apply.

-- 
Jens Axboe

