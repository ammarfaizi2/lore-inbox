Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269807AbUJMUGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269807AbUJMUGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269789AbUJMUGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:06:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7076 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269803AbUJMUEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:04:43 -0400
Message-ID: <416D8A4E.5030106@pobox.com>
Date: Wed, 13 Oct 2004 16:04:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <4165B233.9080405@rtr.ca>
In-Reply-To: <4165B233.9080405@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> On a related note..
> 
> In the longer term, I'd like Jeff & I to get together and agree
> upon some interface changes in libata to make it easier for this
> driver (and others) to share more of the code dealing with
> the emulation of non-data SCSI commands like INQUIRY and friends.
> 
> Right now that's not as easy as it could be, due to the specialized
> libata struct parameters required, but I think it could be harmonized.

I recall this but don't see it in my inbox anymore... did I adequately 
respond?

The easy answer is always:  send patches.  that's the best way to 
illustrate your design, and the quickest way to get the changes you want 
into the kernel.

	Jeff



