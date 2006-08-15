Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWHOOBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWHOOBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWHOOBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:01:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:62401 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030297AbWHOOBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:01:03 -0400
Message-ID: <44E1D39C.60900@garzik.org>
Date: Tue, 15 Aug 2006 10:01:00 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matthieu CASTET <castet.matthieu@free.fr>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Merging libata PATA support into the base kernel
References: <1155144599.5729.226.camel@localhost.localdomain>	<44DA4288.6020806@rtr.ca> <44DACE9F.3090909@garzik.org>	<44DCA67B.5070400@rtr.ca> <ebsibq$qgb$1@sea.gmane.org>
In-Reply-To: <ebsibq$qgb$1@sea.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu CASTET wrote:
> On Fri, 11 Aug 2006 11:47:07 -0400, Mark Lord wrote:
>> And libata already has sufficient ioctl compatibility for nearly all
>> purposes with the old drivers/ide stuff.  Yes, there are some more
>> esoteric ioctls that I once implemented in drivers/ide that do not
>> exist for libata, and nobody will miss them.

> IRRC, there nothing for ATAPI ioctl compatibility, there only things for
> ATA.

What _specifically_ is missing, in your opinion?

	Jeff



