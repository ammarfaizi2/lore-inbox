Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289659AbSBJPCD>; Sun, 10 Feb 2002 10:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289657AbSBJPBy>; Sun, 10 Feb 2002 10:01:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51730 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289655AbSBJPBm>; Sun, 10 Feb 2002 10:01:42 -0500
Subject: Re: ALI 15X3 DMA Freeze
To: kernel@iggy.triode.net.au (Linux Kernel Mailing List)
Date: Sun, 10 Feb 2002 15:15:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020210154209.A15150@iggy.triode.net.au> from "Linux Kernel Mailing List" at Feb 10, 2002 03:42:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZvhB-0003lm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Feb 10 15:25:10 solaris kernel: ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
> Feb 10 15:25:10 solaris kernel: ALI15X3: simplex device:  DMA disabled
> Feb 10 15:25:10 solaris kernel: ide1: ALI15X3 Bus-Master DMA disabled (BIOS)

Why do you have the IDE DMA disabled in the BIOS ? Is that a setting you
made or something your bios knows about your hardware ?
