Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317659AbSFLHPS>; Wed, 12 Jun 2002 03:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317660AbSFLHPR>; Wed, 12 Jun 2002 03:15:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23812 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317659AbSFLHOx>; Wed, 12 Jun 2002 03:14:53 -0400
Subject: Re: linux 2.4.19-preX IDE bugs
To: nick@octet.spb.ru
Date: Wed, 12 Jun 2002 08:36:08 +0100 (BST)
Cc: andre@linux-ide.org (Andre Hedrick), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <002101c2115d$1c0bc7c0$baefb0d4@nick> from "Nick Evgeniev" at Jun 11, 2002 07:31:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I2fo-00073y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed. But all what I see is that STABLE Linux kernel DOESN'T has working
> driver for promise controller (including latest ac patches) for SEVERAL
> MONTHS.

I think you have hosed hardware. Vendors ship a lot of Linux and get
almost no such reports. Things like  the LBA48 hang and VIA hardware
bug showed up well - promise disk corruption -no
