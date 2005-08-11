Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVHKWD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVHKWD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVHKWD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:03:27 -0400
Received: from mail.dvmed.net ([216.237.124.58]:15529 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932207AbVHKWD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:03:26 -0400
Message-ID: <42FBCB29.5040900@pobox.com>
Date: Thu, 11 Aug 2005 18:03:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
References: <B8E391BBE9FE384DAA4C5C003888BE6F041DACC8@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F041DACC8@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
>>Tony, others, does this change give you any heartburn?  On
>>the 460GX and 870 boxes I have, IDE is a PCI device.
> 
> 
> No heartburn for me ... as you say IDE is built into one
> of the 870 chips.
> 
> I don't know whether any non-Intel chipsets provide legacy IDE.

The question is not about ISA IDE, but more about the PCI IDE 
specification...  See the PCI IDE examples in my other emails.

	Jeff



