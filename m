Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272484AbTGaOPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272485AbTGaOPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:15:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24502 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272484AbTGaOPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:15:44 -0400
Message-ID: <3F292478.6040504@pobox.com>
Date: Thu, 31 Jul 2003 10:15:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
CC: "Jens Axboe (E-mail)" <axboe@suse.de>,
       "Marcelo Tosatti (E-mail)" <marcelo@conectiva.com.br>,
       "Lkml (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: cciss updates for 2.4.22
References: <D4CFB69C345C394284E4B78B876C1CF104052AC9@cceexc23.americas.cpqcorp.net>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF104052AC9@cceexc23.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miller, Mike (OS Dev) wrote:
> The attached tarball contains 2 patches. The first is an author change for the cciss driver. The second resolves an issue when sharing IRQs with another controller. The patches have been built & tested against 2.4.22-pre9. They can be installed in any order.
> More to come.


Mike, you should consider sending one-patch-per-email.  This makes it 
much easier for Marcelo to use standard scripts to quickly and easily 
apply your patches.

For the record, the patches look ok to me too.

	Jeff



