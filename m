Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbWGUDBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbWGUDBI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 23:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWGUDBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 23:01:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3006 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964827AbWGUDBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 23:01:06 -0400
Message-ID: <44C0436E.306@garzik.org>
Date: Thu, 20 Jul 2006 23:01:02 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Ed Lin <ed.lin@promise.com>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       hch <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, promise_linux <promise_linux@promise.com>
Subject: Re: [PATCH] Promise 'stex' driver
References: <NONAMEBMcvsq9IcVux1000001f9@nonameb.ptu.promise.com> <44BFF539.4000700@garzik.org> <1153439728.4754.19.camel@mulgrave> <44C01CD7.4030308@garzik.org> <20060721010724.GB24176@suse.de> <44C02D1E.4090206@garzik.org> <20060721013822.GA25504@suse.de> <44C037B3.4080707@garzik.org> <20060721023647.GA29220@suse.de>
In-Reply-To: <20060721023647.GA29220@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> If I thought that it would ever be updated to use block tagging, I would
> not care at all. The motivation to add it from the Promise end would be
> zero, as it doesn't really bring any immediate improvements for them. So
> it would have to be done by someone else, which means me or you. I don't
> have the hardware to actually test it, so unless you do and would want
> to do it, chances are looking slim :-)
> 
> It's a bit of a chicken and egg problem, unfortunately. The block layer
> tagging _should_ be _the_ way to do it, and as such could be labelled a
> requirement. I know that's a bit harsh for the Promise folks, but
> unfortunately someone has to pay the price...

I think it's highly rude to presume that someone who has so-far been 
responsive, and responsible, will suddenly not be so.  That is not the 
way to encourage vendors to join the Linux process.

They set up an alias for Linux maintainer stuff and have been acting 
like a maintainer that will stick around.  Why punish them for good 
behavior?

	Jeff


