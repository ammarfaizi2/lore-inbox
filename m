Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273604AbRIQM5q>; Mon, 17 Sep 2001 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273603AbRIQM5g>; Mon, 17 Sep 2001 08:57:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57356 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273602AbRIQM5d>; Mon, 17 Sep 2001 08:57:33 -0400
Subject: Re: Athlon bug - Abit KT7E
To: mmark@koala.ichpw.zabrze.pl
Date: Mon, 17 Sep 2001 14:02:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <200109171242.f8HCgVZ00681@koala.ichpw.zabrze.pl> from "Marek Mentel" at Sep 17, 2001 02:31:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15iy2T-00077a-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sep 15 13:19:40 bulma kernel: hda: dma_intr: status=0x71 { DriveReady
> DeviceFaul
> t SeekComplete Error }
> Sep 15 13:19:40 bulma kernel: hda: dma_intr: error=0x10 {
> SectorIdNotFound }, LB
> Asect=9484373, sector=3604580
> Sep 15 13:19:40 bulma kernel: hda: DMA disabled
> Sep 15 13:19:40 bulma kernel: ide0: reset: success

The "DeviceFault" message came from the drive as did the "SectorIDNotFound".
I'd make sure you have a backup of that drive contents.

Alan
