Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291627AbSBNNT3>; Thu, 14 Feb 2002 08:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291630AbSBNNTZ>; Thu, 14 Feb 2002 08:19:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37906 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291627AbSBNNTI>; Thu, 14 Feb 2002 08:19:08 -0500
Subject: Re: Promise SuperTrak100 Oops/Kernel Panic
To: rlake@colabnet.com (Rob Lake)
Date: Thu, 14 Feb 2002 13:33:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1013650921.2150.5.camel@sphere878.hive.colabnet.com> from "Rob Lake" at Feb 13, 2002 10:12:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bM0V-0008SB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Feb 13 21:52:15 sphere878 kernel: i2o/hda: Disk Storage: 305274MB, 512
> byte sectors.
> Feb 13 21:52:15 sphere878 kernel: i2o/hda: Maximum sectors/read set to
> 32.

It found the block array happily.

> Feb 13 21:52:17 sphere878 kernel:  i2o/hda:r 3
> Feb 13 21:52:17 sphere878 kernel: I2O: Spurious reply to handler 3
> Feb 13 21:52:17 sphere878 last message repeated 454 times

Then things seem to go a little mad, and its getting bogus messages to
a drivert that has been unloaded
