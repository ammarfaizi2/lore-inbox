Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbSKLPet>; Tue, 12 Nov 2002 10:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSKLPet>; Tue, 12 Nov 2002 10:34:49 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:38310 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266609AbSKLPeZ>; Tue, 12 Nov 2002 10:34:25 -0500
Subject: Re: PDC20276 Linux driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ricci@trinityteam.it
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0211121637280.9631-100000@esentar.trinityteam.it>
References: <Pine.LNX.4.21.0211121637280.9631-100000@esentar.trinityteam.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 16:06:06 +0000
Message-Id: <1037117166.8313.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 15:43, ricci@trinityteam.it wrote:
> During Slackware installation (whith kernel compiled by myself), after
> about half a gigabyte written in the disk/disks all process
> reading/writeing from/to the disks stop running, I cannot kill them, ps
> show me them with the 'D' flag, I cannot umount the disk/disks.

What drives, exactly what messages are logged (dmesg) ?

