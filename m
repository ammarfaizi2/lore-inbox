Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291811AbSBNRyS>; Thu, 14 Feb 2002 12:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291806AbSBNRyD>; Thu, 14 Feb 2002 12:54:03 -0500
Received: from steam.colabnet.com ([198.165.224.35]:14085 "EHLO
	torsus.hive.colabnet.com") by vger.kernel.org with ESMTP
	id <S291802AbSBNRxw>; Thu, 14 Feb 2002 12:53:52 -0500
Subject: Re: Promise SuperTrak100 Oops/Kernel Panic
From: Rob Lake <rlake@colabnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16bM0V-0008SB-00@the-village.bc.nu>
In-Reply-To: <E16bM0V-0008SB-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 14 Feb 2002 14:27:15 -0330
Message-Id: <1013709435.7084.7.camel@sphere878.hive.colabnet.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-14 at 10:03, Alan Cox wrote:

> > Feb 13 21:52:17 sphere878 kernel:  i2o/hda:r 3
> > Feb 13 21:52:17 sphere878 kernel: I2O: Spurious reply to handler 3
> > Feb 13 21:52:17 sphere878 last message repeated 454 times
> 
> Then things seem to go a little mad, and its getting bogus messages to
> a drivert that has been unloaded

Is there a driver I should be loading pre i2o_block?
Rob

