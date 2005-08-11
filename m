Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVHKTXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVHKTXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVHKTXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:23:23 -0400
Received: from mail.dvmed.net ([216.237.124.58]:1448 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932370AbVHKTXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:23:22 -0400
Message-ID: <42FBA5A5.4010507@pobox.com>
Date: Thu, 11 Aug 2005 15:23:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml@dodo.com.au
CC: "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com> <j9ime15b20eq23q1bnrbh1fnj34gch7lbp@4ax.com>
In-Reply-To: <j9ime15b20eq23q1bnrbh1fnj34gch7lbp@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> For: 
> 
> linux-2.6.13-rc4:
> 118 pci_ids-defined_elsewhere-files
> 475 pci_ids-defined_elsewhere-items
> 7 pci_ids-duplicate-items
> 2321 pci_ids-list
> 725 pci_ids-not_used
> 
> linux-2.6.13-rc3-mm3:
> 119 pci_ids-defined_elsewhere-files
> 475 pci_ids-defined_elsewhere-items
> 7 pci_ids-duplicate-items
> 2325 pci_ids-list
> 723 pci_ids-not_used
> 
> Should the 'defined elsewhere' items be brought into the one 
> pci_ids.h file?  Testing will take time.  Patch is ~70kB.


Separate change, separate patch.

	Jeff


