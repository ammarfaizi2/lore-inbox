Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288622AbSANBlv>; Sun, 13 Jan 2002 20:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288633AbSANBlk>; Sun, 13 Jan 2002 20:41:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50957 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288604AbSANBl3>; Sun, 13 Jan 2002 20:41:29 -0500
Subject: Re: Linux 2.4.18pre3-ac1-aia21 (IDE patches)
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Mon, 14 Jan 2002 01:53:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020113232757.04f34ec0@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Jan 14, 2002 01:07:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PwJO-0000F8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan's -ac series is back! To celebrate this I added in the IDE patches and 
> an NTFS update which dramatically reduces the number of vmalloc()s and have 
> posted the resulting (tested) patch (to be applied on top of 
> 2.4.18pre3-ac1) at below URL.

Andre's IDE patch is in the ac2 cut. I took it out just to make testing easier
in case other people found -ac1 wasnt as reliable as I did 8)

Alan
