Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277237AbRJ0WGK>; Sat, 27 Oct 2001 18:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277244AbRJ0WGA>; Sat, 27 Oct 2001 18:06:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8967 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277237AbRJ0WFs>; Sat, 27 Oct 2001 18:05:48 -0400
Subject: Re: Radeon Frame Buffer
To: louisg00@bellsouth.net (Louis Garcia)
Date: Sat, 27 Oct 2001 23:12:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <1004210340.4537.20.camel@tiger> from "Louis Garcia" at Oct 27, 2001 03:18:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xbhI-0004VB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm having a weird problem with the version that comes with the latest
> -ac kernels. Once the driver read the bios it stops scrolling during
> boot.

 *	drivers/video/radeonfb.c
 *	framebuffer driver for ATI Radeon chipset video boards
 *
 *	Copyright 2000	Ani Joshi <ajoshi@unixbox.com>
