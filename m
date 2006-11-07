Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754110AbWKGIaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbWKGIaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbWKGIaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:30:17 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:58545 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754110AbWKGIaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:30:15 -0500
Message-ID: <45504415.2050609@garzik.org>
Date: Tue, 07 Nov 2006 03:30:13 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: arcmsr destiny
References: <20061107053840.GA26920@washoe.onerussian.com>
In-Reply-To: <20061107053840.GA26920@washoe.onerussian.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Halchenko wrote:
> Dear Kernel People,
> 
> I've spent some time trying to figure out what has happened with an
> attempt to adapt arcmsr driver. Its timeline within -mm branch
> seems to stop at removal of areca-raid-linux-scsi-driver.patch within
> 2.6.18-rc3-mm1, but announcement.txt doesn't have any description why
> that happened and if there is intent of future development.
> 
> As I understood from the correspondence included in the patchfile, the
> driver  as it was provided by the manufacture is not very nice or at
> least has some issues. Thus I would be really thrilled to see it
> adopted in the mainstream of kernel development.

Not sure what you are asking.  acrmsr was merged upstream, and will be 
in all future kernels.

	Jeff



