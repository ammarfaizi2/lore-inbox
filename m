Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263390AbVCEAAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbVCEAAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbVCDX4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:56:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15577 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263390AbVCDXBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:01:17 -0500
Message-ID: <4228E8A4.6080003@pobox.com>
Date: Fri, 04 Mar 2005 18:00:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       davej@redhat.com
Subject: Re: [PATCH] convert pci_dev->slot_name usage to pci_name()
References: <11099696352086@kroah.com> <4228CC6D.8040606@pobox.com> <20050304210714.GA426@kroah.com>
In-Reply-To: <20050304210714.GA426@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Mar 04, 2005 at 04:00:29PM -0500, Jeff Garzik wrote:
> 
>>Greg KH wrote:
>>
>>>ChangeSet 1.1998.11.6, 2005/02/07 14:36:14-08:00, davej@redhat.com
>>>
>>>[PATCH] convert pci_dev->slot_name usage to pci_name()
>>>
>>>Prepare for removal of pci_dev->slot_name
>>
>>Can you split this up and send me the drivers/net/* portion?
> 
> 
> Here ya go.
> 
> thanks,
> 
> greg k-h

Thanks, applied.

	Jeff



