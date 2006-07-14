Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWGNOgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWGNOgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbWGNOga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:36:30 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:25615 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161011AbWGNOga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:36:30 -0400
Date: Fri, 14 Jul 2006 10:35:39 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       achirica@users.sourceforge.net, "David C. Hansen" <haveblue@us.ibm.com>,
       serue@us.ibm.com, clg@fr.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: airo.c
Message-ID: <20060714143527.GA1738@tuxdriver.com>
References: <20060713205319.GA23594@us.ibm.com> <20060713212824.GA14729@infradead.org> <20060713230018.GA24359@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713230018.GA24359@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 04:00:18PM -0700, Sukadev Bhattiprolu wrote:
> Christoph Hellwig [hch@infradead.org] wrote:
> | On Thu, Jul 13, 2006 at 01:53:19PM -0700, Sukadev Bhattiprolu wrote:
> | > Andrew,
> | > 
> | > Javier Achirica, one of the major contributors to drivers/net/wireless/airo.c
> | > took a look at this patch, and doesn't have any problems with it. It doesn't
> | > fix any bugs and is just a cleanup, so it certainly isn't a candidate
> | > for this mainline cycle
> | 
> | I'm not sure it's that easy.  I think it needs some more love:

> My inital goal was to  replace kernel_thread() with kthread_*(). So can I
> assume you are ok with my patch and that it can go in as is ?

Could you please repost your (final) patch(es) to
netdev@vger.kernel.org, and cc: me as well?  I missed your original
post, since it was (apparently) just to LKML.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
