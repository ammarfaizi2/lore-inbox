Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbWGJSbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbWGJSbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWGJSbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:31:32 -0400
Received: from main.gmane.org ([80.91.229.2]:12475 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965202AbWGJSbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:31:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Steve Fox <drfickle@us.ibm.com>
Subject: Re: Linux v2.6.18-rc1
Date: Mon, 10 Jul 2006 13:30:31 -0500
Organization: IBM
Message-ID: <pan.2006.07.10.18.30.30.338580@us.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <pan.2006.07.07.15.41.35.528827@us.ibm.com> <1152441242.4128.33.camel@localhost.localdomain> <1152549482.2658.29.camel@flooterbu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 24-159-197-73.dhcp.roch.mn.charter.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Cc: linuxppc-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 11:38:02 -0500, Steve Fox wrote:

> Also, booting with ide=nodma, as Alan suggested to Will, did not help.

I'm not sure if it was due to using the nodma parameter or not, but I did
get a few more details during this boot. No idea if they're useful or not.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2 ide:
Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:04.1 AMD8111: chipset revision
3 AMD8111: 0000:00:04.1 (rev 03) UDMA133 controller AMD8111: 100% native
mode on irq 17
    ide0: BM-DMA at 0x7c00-0x7c07, BIOS settings: hda:pio, hdb:pio ide1:
    BM-DMA at 0x7c08-0x7c0f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK4019GAXB, ATA DISK drive ide0 at 0x7400-0x7407,0x6c02 on
irq 17 hda: max request size: 128KiB
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: 78140160 sectors (40007 MB), CHS=65535/16/63 hda: lost interrupt hda:
cache flushes supported
 hda:<4>hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
 hda1 hda2 hda3 hda4 <<4>hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
 hda5<4>hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt


-- 

Steve Fox
IBM Linux Technology Center


