Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292104AbSBTRfe>; Wed, 20 Feb 2002 12:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292107AbSBTRf1>; Wed, 20 Feb 2002 12:35:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46090 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292104AbSBTRfM>; Wed, 20 Feb 2002 12:35:12 -0500
Subject: Re: 2.5.4 PNPBIOS fault
To: rddunlap@osdl.org (Randy.Dunlap)
Date: Wed, 20 Feb 2002 17:49:21 +0000 (GMT)
Cc: jdthood@mail.com (Thomas Hood), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0202200906431.3312-100000@dragon.pdx.osdl.net> from "Randy.Dunlap" at Feb 20, 2002 09:22:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16darp-0004Da-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | PnPBIOS: Found PnP BIOS installation structure at 0xc00f6010.
> | PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb4a6, dseg 0x400.
> | Unable to handle kernel paging request at virtual address 0000de3a
> |  printing eip:
> |  00004298

That looks like it choked from the pnpbios yes. Is this an intel bios ?

Send me some DMI strings
