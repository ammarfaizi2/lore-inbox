Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293169AbSCADHt>; Thu, 28 Feb 2002 22:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293243AbSCADDr>; Thu, 28 Feb 2002 22:03:47 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:4508 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S310378AbSCAC5T>;
	Thu, 28 Feb 2002 21:57:19 -0500
Date: Thu, 28 Feb 2002 18:28:40 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Arnvid Karstad <arnvid@karstad.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.x, ThinkPad T23 and HW?!
Message-ID: <439475061.1014920919@[10.10.2.3]>
In-Reply-To: <20020228233954.7840.qmail@nextgeneration.speedroad.net>
In-Reply-To: <20020228233954.7840.qmail@nextgeneration.speedroad.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just recieved an new laptop, an IBM ThinkPad T23 and it seems I cannot
> run the os of my choice on it.. Well almost not.. ;-)  The machine is an
> PIII Mobile - 1133Mhz with built in ethernet, Bluetooth, modem and
> Wireless adapters. Namly Intel PRO/100 VE, IBM BlueTooth USB/UltraPort
> thingy, Lucent Softmodem AMR and IBM High Rate Wireless LAN MiniPCI
> "combo" card. The strange thing is, almost none of these come up as
> "known" devices from /proc/pci or lspci. I also noticed that the IBM
> Wireless adapter, which is actually a prism2 (?) card, are mysteriously
> detected as an device created by "Harris Semiconductor" and it won't even
> try to let me access the card. I think I've tried every driver in the
> Kernel 2.4.18 now. Altho the kernel does state that the card in question
> is supported, it does seem that either the pci/device-id has changed (or
> something) so the driver doesn't notice any cards???  The hermes modules
> loads but no interfaces become available.

The tales of my brother's intrepid exploits with the T23 are
at: http://www.alex.org.uk/T23/index.html - I think there are
instructions there on how to beat the wireless into submission
(and other things) there.

Martin.

