Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVBSRJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVBSRJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 12:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVBSRJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 12:09:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34699 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261741AbVBSRJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 12:09:29 -0500
Message-ID: <421772B2.7050100@pobox.com>
Date: Sat, 19 Feb 2005 12:09:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] libata-dev queue updated
References: <4216FB7B.3030409@pobox.com> <4217703E.4070307@tomt.net>
In-Reply-To: <4217703E.4070307@tomt.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> Jeff Garzik wrote:
> 
>> Patch URL, BK URL, and changelog attached.
>>
>> Recent changes:
>> * New sata_qstor driver.
>>
>> * Turn on ATAPI by default.
>>
>> * Change a couple unconditional use-the-hardware function calls to be 
>> callbacks instead.  Should have been this way originally.
>>
>> * Most of C/H/S support.
>>
>> * Fix bugs in ADMA driver.
>>
>> * Support PCI MSI in AHCI driver.
>> * Support ATAPI in AHCI driver.
>>
>> * Improve ATA passthru (a.k.a. SMART) support
>>
> 
> How is the Marvell driver coming along? Did it stall? :-)

Yeah, it's stalled...

	Jeff



