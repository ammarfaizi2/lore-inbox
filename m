Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280982AbRKOSg5>; Thu, 15 Nov 2001 13:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280985AbRKOSgr>; Thu, 15 Nov 2001 13:36:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47886 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280982AbRKOSgl>; Thu, 15 Nov 2001 13:36:41 -0500
Subject: Re: Maestro 2E vs. Power mgmt
To: mochel@osdl.org (Patrick Mochel)
Date: Thu, 15 Nov 2001 18:44:19 +0000 (GMT)
Cc: fauxpas@temp123.org (Faux Pas III), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111151011370.21985-100000@segfault.osdlab.org> from "Patrick Mochel" at Nov 15, 2001 10:16:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164RUq-0001GJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (On a side note, it looks like the driver is manually touching a lot of
> PCI config space rather than using the pci_ wrappers...)

It does PCI power management in 2.2 as well..
