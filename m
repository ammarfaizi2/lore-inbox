Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136518AbRD3UJg>; Mon, 30 Apr 2001 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136517AbRD3UJ1>; Mon, 30 Apr 2001 16:09:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136516AbRD3UJA>; Mon, 30 Apr 2001 16:09:00 -0400
Subject: Re: DMA support in cs5530 IDE driver? (repost)
To: mshiloh@mediabolic.com (Michael Shiloh)
Date: Mon, 30 Apr 2001 21:13:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104301124210.32533-100000@michael.channeldot.com> from "Michael Shiloh" at Apr 30, 2001 11:29:06 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uK2a-0000Ib-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can anyone report success or failure with enabling DMA for
> the CS5530 IDE driver? I can get my system to crash or at
> least hang pretty reliably by using hdparm to turn on DMA
> while reading an MPEG-2 movie from my hard disk drive.

My palmtop is a CS5530/MediaGX233 and seems stable with 2.4.*-ac. Im probably
not hitting the disk as hard as you though

