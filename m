Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTHZXyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 19:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbTHZXyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 19:54:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40592 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263012AbTHZXyh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 19:54:37 -0400
Message-ID: <3F4BF331.4040706@pobox.com>
Date: Tue, 26 Aug 2003 19:54:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add a couple pci ids to pci_ids.h
References: <Pine.GSO.4.21.0308221801120.13238-100000@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0308221801120.13238-100000@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> On Fri, 22 Aug 2003, Linux Kernel Mailing List wrote:
> 
>>ChangeSet 1.1104, 2003/08/22 08:53:10-03:00, jgarzik@pobox.com
>>
>>	[PATCH] add a couple pci ids to pci_ids.h
>>
>>diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>--- a/include/linux/pci_ids.h	Fri Aug 22 05:02:40 2003
>>+++ b/include/linux/pci_ids.h	Fri Aug 22 05:02:40 2003
>>@@ -1648,6 +1648,9 @@
>> #define PCI_DEVICE_ID_TIGON3_5703	0x1647
> 
> 
> 0x1647 = 5703
> 
> 
>> #define PCI_DEVICE_ID_TIGON3_5704	0x1648
> 
> 
> 0x1648 = 5704
> 
> 
>> #define PCI_DEVICE_ID_TIGON3_5702FE	0x164d
>>+#define PCI_DEVICE_ID_TIGON3_5705	0x1653
> 
> 
> 0x1653 != 5705 -> *** BEEP ***
> 0x1653 = 5715


The card I have seems to say 5705 on the chip :)  I've never heard of a 
5715, even.  Weird :)

	Jeff



