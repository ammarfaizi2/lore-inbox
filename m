Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSLYHAF>; Wed, 25 Dec 2002 02:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSLYHAF>; Wed, 25 Dec 2002 02:00:05 -0500
Received: from [209.195.52.121] ([209.195.52.121]:21948 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S266108AbSLYHAE>; Wed, 25 Dec 2002 02:00:04 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 24 Dec 2002 22:56:01 -0800 (PST)
Subject: aic7xxx won't boot in v2.5.53
In-Reply-To: <Pine.LNX.4.44.0212232141010.1079-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212242251460.14400-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when I try to boot 2.5.53 with the 6.2.24 'new' aic7xxx driver I get an
error message
aic 7xxx PCI Device 0:10:0 failed memory mapped test useing PIO
and then the initial information block about the card, then nothing, it
never finishes downloading the firmware or detects the drives.

I am sucessfully useing 2.4.18 on this box, but have been unable to use
any of the recent 2.5 kernels, prior to .53 they were not detecting any of
the disks.

David Lang
