Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbSJ1VzH>; Mon, 28 Oct 2002 16:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSJ1VzH>; Mon, 28 Oct 2002 16:55:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:26833 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261461AbSJ1VzG>; Mon, 28 Oct 2002 16:55:06 -0500
Subject: Re: What does "hdX: CHECK for good STATUS" mean?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Feiler <kiza@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210282247.37737.kiza@gmx.net>
References: <200210282247.37737.kiza@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 22:20:17 +0000
Message-Id: <1035843617.3552.67.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 21:47, Oliver Feiler wrote:
> Btw, why is the drive not set to UDMA(33) on boot (like the other 80 GB 
> Samsung drive)? I haven't found the drive in the ida-dma.c UDMA blacklists. 
> Could this be some braindead BIOS thing? I had to flash a beta BIOS (Asus 
> P5A-B) to get the board to boot with the 80 GB disks at all.

Because there are known problems with some combinations of WD drives and
Ali controllers.

