Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVFRUk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVFRUk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 16:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVFRUk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 16:40:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44179 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261299AbVFRUkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 16:40:22 -0400
Message-ID: <42B486B2.6050608@pobox.com>
Date: Sat, 18 Jun 2005 16:40:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sean darcy <seandarcy2@gmail.com>
CC: Linux IDE <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: does AHCI work on intel 915 ICH6 controllers? Is it supposed
 to?
References: <d87q4j$d37$1@sea.gmane.org> <42A7A191.7040700@pobox.com>	 <d89hcm$7ej$1@sea.gmane.org> <42AD0305.5060705@tw.ibm.com> <c195ebf705061813191a48a69f@mail.gmail.com>
In-Reply-To: <c195ebf705061813191a48a69f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sean darcy wrote:
> Mine is also 0x2651.
> 
> But I must be blind, but I don't see any statement that  only  -R and
> -M have AHCI support.


Here's my statement :)

PCI ID 0x2651 does not have AHCI support in the chip.

No amount of BIOS poking can fix that.

	Jeff


