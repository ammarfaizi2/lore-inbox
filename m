Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265622AbUEZPZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUEZPZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 11:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUEZPZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 11:25:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:17589 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265622AbUEZPZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 11:25:15 -0400
Message-ID: <40B4ADA2.2020604@pobox.com>
Date: Wed, 26 May 2004 10:45:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Len Brown <len.brown@intel.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org,
       "linux-pci@atrey.karlin.mff.cuni.cz" 
	<linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: ACPI & 2.4 (Re: [BK PATCH] PCI Express patches for 2.4.27-pre3)
References: <A6974D8E5F98D511BB910002A50A6647615FC676@hdsmsx403.hd.intel.com> <1085556934.26254.132.camel@dhcppc4> <20040526073752.GF6742@devserv.devel.redhat.com>
In-Reply-To: <20040526073752.GF6742@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, May 26, 2004 at 03:35:34AM -0400, Len Brown wrote:
> 
>>Yes, the ACPI part to enable MMconfig was pretty small.
>>We parse a table in the standard way and set a global variable --
>>that's about it.
>>
>>I submitted it to 2.4 for the sole purpose
>>to enable Greg to enable native PCIExpress.
>>
>>I expect demand for this in 2.4 as the major distros'
>>enterprise releases are still 2.4 based and the hardware has
>>arrived... 
> 
> 
> yet those enterprise releases won't go to newer 2.4 upstream releases....


Len is right in guessing enterprise releases want PCI Express support 
though :)

	Jeff


