Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbRFBWI0>; Sat, 2 Jun 2001 18:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbRFBWIG>; Sat, 2 Jun 2001 18:08:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6929 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261783AbRFBWH4>; Sat, 2 Jun 2001 18:07:56 -0400
Subject: Re: PATCH 2.4.5.ac6: more Via irq fixes
To: j.jvriezen@freeler.nl
Date: Sat, 2 Jun 2001 23:06:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m156JR5-000lhIC@green.nl.gxn.net> from "Koos Vriezen" at Jun 03, 2001 12:00:52 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156JWy-0002Df-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In case you didn't know, the patch doesn't solve interrup conflicts on 
> VIA Apollo MVP3 chipsets. Box runs fine though.

It has no bearing on the VIA MVP3.

> PCI: Found IRQ 10 for device 00:0a.0
> IRQ routing conflict in pirq table for device 00:0a.0
> IRQ routing conflict in pirq table for device 00:0a.1

That is a bios table problem, so almost cerainly not a Linux item

