Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273013AbRIISoe>; Sun, 9 Sep 2001 14:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273014AbRIISoY>; Sun, 9 Sep 2001 14:44:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17926 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273013AbRIISoH>; Sun, 9 Sep 2001 14:44:07 -0400
Subject: Re: 2.4.9 modules + unresovled symbols
To: davidtl@rcn.com.hk (David Chow)
Date: Sun, 9 Sep 2001 19:48:17 +0100 (BST)
Cc: faybaby@enter.net (faybaby), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109100055370.11973-100000@uranus.planet.rcn.com.hk> from "David Chow" at Sep 10, 2001 01:11:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15g9cv-0007fW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> of the kernel modules (drivers) are not compatible to the kernel API. Such
> as a SCSI controller driver PCI2000 PCI2220i and one of the V4L driver
> modules, these modules not even get through the compiler, and how come no
> one reporting this and fix them up from version to version? Since we are

Because they work for us ? I build the pci2000, pci2220i in all my
builds

