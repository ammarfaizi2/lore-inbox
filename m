Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUD2DRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUD2DRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUD2DR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:17:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35810 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263041AbUD2DRS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:17:18 -0400
Message-ID: <409073B1.1020901@pobox.com>
Date: Wed, 28 Apr 2004 23:17:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sata] new driver -- AHCI
References: <408C1F41.3060206@pobox.com> <40905997.9020107@tomt.net>
In-Reply-To: <40905997.9020107@tomt.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> Jeff Garzik wrote:
> 
>> So kudos to the AHCI folks (mainly at Intel), for making a decent, 
>> open controller.  I always prefer to work on drivers for decent 
>> hardware, whose hardware specification is open and public.
> 
> 
> Quick questions:
> 
> Is the Intel 6300ESB ("Hence Rapids") AHCI based? So far this looks like 
> ICH6 too me, but I may be mistaken.

The only Hance Rapids stuff I've seen was ICH5-R, but maybe it's carried 
forward to the ICH6-R as well.

I don't know, I mainly know the underlying chipsets not the boards they 
wind up being shipped on...


> What about the Marvell 88SX5040 PCI-X SATA Controller?

Coming RSN.  That's my next priority, but I'm not as thrilled because 
Marvell isn't an open design like AHCI.  I'm much more happy to promote 
AHCI's sane, open design.

	Jeff



