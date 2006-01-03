Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWACSzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWACSzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWACSzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:55:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22309 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932484AbWACSzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:55:13 -0500
Date: Tue, 3 Jan 2006 19:57:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year, libata hackers
Message-ID: <20060103185702.GX2772@suse.de>
References: <43BAB977.3010203@pobox.com> <20060103183328.GW2772@suse.de> <43BAC822.6090501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BAC822.6090501@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Tue, Jan 03 2006, Jeff Garzik wrote:
> >
> >>Port multiplier and NCQ (queueing) support are the two other big to-do 
> >>items on the list.
> >
> >
> >I'll get NCQ updated and tested again in the not-so-distant future.
> 
> FWIW I've kept it moderately up-to-date in the 'ncq' branch.  It's 
> definitely moldy, with a few FIXMEs in libata-scsi's read/write 
> translation, for example, which is missing the NCQ portion of that code.
> 
> 	Jeff

Yeah that, and Tejun had some good updates for it as well. I'll take a
look as soon as I get some time to do so.

-- 
Jens Axboe

