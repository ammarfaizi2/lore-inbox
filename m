Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWINKRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWINKRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWINKRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:17:47 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:34254 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S1750746AbWINKRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:17:46 -0400
From: Thomas Richter <thor@mail.math.tu-berlin.de>
Message-Id: <200609141017.k8EAHdL9017691@mersenne.math.TU-Berlin.DE>
Subject: APIC on Asus M2N SLI Deluxe
To: linux-kernel@vger.kernel.org
Date: Thu, 14 Sep 2006 12:17:39 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL108 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

recently, I tried to upgrade the bios of the ASUS M2N SLI Deluxe
board from release 0202 to 0307. With the 0307 bios, I get a kernel
panic that the APIC cannot be found. Concerning this, I've two
explanations, could possibly confirm someone here this:

a) the kernel has a workaround against some bios flaw of the ASUS
board that only works for the 0202 and which does not recognize the
0307 bios as problematic, so it fails on the newer bios,

- or -

b) ASUS managed to screw the bios for 0307, even though 0202 was
fine.

It's not a major problem for me right now, the 0202 bios works like
a charm with the 2.6.17.8 kernel. I'm just curious.

So long,
	Thomas
