Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317452AbSF1PCk>; Fri, 28 Jun 2002 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317453AbSF1PCj>; Fri, 28 Jun 2002 11:02:39 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15031 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317452AbSF1PCi>; Fri, 28 Jun 2002 11:02:38 -0400
Date: Fri, 28 Jun 2002 11:04:53 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200206281504.g5SF4rA19032@devserv.devel.redhat.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB doesn't work
In-Reply-To: <mailman.1025183101.8745.linux-kernel2news@redhat.com>
References: <mailman.1025183101.8745.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Running 2.4.19-rc1 or 2.4.18, the following chipset won't work with a USB=
>=20
> keyboard attached:

> usb-ohci.c: USB OHCI at membase 0xc4802000, IRQ 10
> usb-ohci.c: usb-00:13.0, Compaq Computer Corporation ZFMicro Chipset USB
> usb-ohci.c: USB HC TakeOver failed!

This is a BIOS screwage. What was the last kernel that worked?

-- Pete
