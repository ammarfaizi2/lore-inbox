Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274883AbRJAL2L>; Mon, 1 Oct 2001 07:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274886AbRJAL2B>; Mon, 1 Oct 2001 07:28:01 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:36243 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S274883AbRJAL1n>; Mon, 1 Oct 2001 07:27:43 -0400
Subject: USB Issues on 2.4
From: Stephane Dudzinski <stephane@antefacto.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 01 Oct 2001 12:24:33 +0100
Message-Id: <1001935474.17479.25.camel@steph>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to bring your attention to some USB issues i experienced
with a USB mouse and normal PS/2 keyboard (not USB).

I installed a usb mouse on 2 systems, one being a pure intel with an
i810 chipset and the other being a via 686b chipset.

First one (the intel) behaves fine, all modules loading up okay and all
working smoothly.

Second one (via from hell) locks up the keyboard as soon as the usb-uhci
is loaded up. This behavior happened on both 2.4.9 and 2.4.10 final
kernels.

I've been pointed to some bios issues with ABIT boards (got a KT7A-RAID)
and especially IRQ sharing (got alot of PCI cards in the box).

I thought it might be useful to send this email.
Steph

-- 
__________________________________________
Stephane Dudzinski   Systems Administrator
a n t e f a c t o     t: +353 1 8586009
www.antefacto.com     f: +353 1 8586014

