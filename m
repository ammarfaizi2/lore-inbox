Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVCDWSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVCDWSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbVCDWRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:17:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16062 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263096AbVCDVAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:00:49 -0500
Message-ID: <4228CC6D.8040606@pobox.com>
Date: Fri, 04 Mar 2005 16:00:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg K-H <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       davej@redhat.com
Subject: Re: [PATCH] convert pci_dev->slot_name usage to pci_name()
References: <11099696352086@kroah.com>
In-Reply-To: <11099696352086@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> ChangeSet 1.1998.11.6, 2005/02/07 14:36:14-08:00, davej@redhat.com
> 
> [PATCH] convert pci_dev->slot_name usage to pci_name()
> 
> Prepare for removal of pci_dev->slot_name

Can you split this up and send me the drivers/net/* portion?

	Jeff



