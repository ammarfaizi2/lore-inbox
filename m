Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271811AbTG2P4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271833AbTG2P4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:56:23 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:6116 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S271811AbTG2P4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:56:21 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: <linux-kernel@vger.kernel.org>, <herbert@13thfloor.at>
Subject: RE: Problems related to DMA or DDR memory on Intel 845 chipset?
Date: Tue, 29 Jul 2003 12:07:41 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGAELOCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <m3he55xwo7.fsf@defiant.pm.waw.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Actually I was thinking about an IC on your card, something like
>PLX PCI9080 chip - i.e. the chip connected to the PCI bus and doing
>the DMA transfers (many specialized controllers have built-in PCI
>bridge, though).

We have an Altera EPLD on our device which is PCI 2.2 compliant.

>Could you please state if you are using bus mastering PCI DMA, or
>if it is IDE DMA (an IDE hard disk etc) thing?

bus master DMA.

Regards,
Kathy

