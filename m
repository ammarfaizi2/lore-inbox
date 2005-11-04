Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbVKDDfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbVKDDfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbVKDDfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:35:15 -0500
Received: from mail.dvmed.net ([216.237.124.58]:15285 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030590AbVKDDfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:35:14 -0500
Message-ID: <436AD6EB.3090100@pobox.com>
Date: Thu, 03 Nov 2005 22:35:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Parallel ATA with libata status with the patches I'm working
 on
References: <1131029686.18848.48.camel@localhost.localdomain>	 <20051103144830.GF28038@flint.arm.linux.org.uk> <1131033483.18848.71.camel@localhost.localdomain>
In-Reply-To: <1131033483.18848.71.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I've not really looked much outside of the PCI space yet (my first goal
> is to rescue the PC world and to get testing it wants x86 users) but
> Jeffs core libata code is strictly bus agnostic.

Some embedded dude (a Finn, I don't remember his name) wrote a libata 
SATA driver for his company's embedded SATA controller... on the ARM 
platform.

Though the driver itself hasn't appeared, libata is apparently working 
quite well with this embedded, non-PCI, ARM SATA chip.

	Jeff


