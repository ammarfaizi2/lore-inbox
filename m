Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSGHSah>; Mon, 8 Jul 2002 14:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSGHSaF>; Mon, 8 Jul 2002 14:30:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24584 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317081AbSGHS3T>; Mon, 8 Jul 2002 14:29:19 -0400
Subject: Re: hd_geometry question.
To: zippel@linux-m68k.org (Roman Zippel)
Date: Mon, 8 Jul 2002 19:55:11 +0100 (BST)
Cc: aebr@win.tue.nl (Andries Brouwer),
       schwidefsky@de.ibm.com (Martin Schwidefsky),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207040144500.8911-100000@serv> from "Roman Zippel" at Jul 04, 2002 01:48:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17RdfD-0002wp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 3 Jul 2002, Andries Brouwer wrote:
> 
> > It is rumoured that certain MO disks with a hardware sector size
> > of 2048 bytes have partition tables in units of 2048-byte sectors.
> 
> Why is it a rumour? AFAIK under DOS/Windows the partition table is in
> units of sector size.

Yes. I have Fujitsu M/O drives with this property.
