Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262575AbRFBOPM>; Sat, 2 Jun 2001 10:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbRFBOPC>; Sat, 2 Jun 2001 10:15:02 -0400
Received: from 8.ylenurme.ee ([193.40.6.8]:49931 "EHLO ns.linking.ee")
	by vger.kernel.org with ESMTP id <S262564AbRFBOOv>;
	Sat, 2 Jun 2001 10:14:51 -0400
Date: Sat, 2 Jun 2001 16:14:47 +0200 (GMT-2)
From: Elmer Joandi <elmer@linking.ee>
To: linux-kernel@vger.kernel.org
Subject: HANG 2.4.5-ac5: Netfinity 3000 IDE cdrom DMA enable
Message-ID: <Pine.LNX.4.21.0106021609150.10632-100000@ns.linking.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



when dma enabled by default, hangs
No time for exact investigation as the computer is here only for
installation.

There is SMP MB, UP kernel.
SCSI HDD

IDE CDROM: CRD-8400B,ATAPI CD/DVD-ROM drive

hdparm utility says on /dev/hdc:

	getmultcount
	getnovers
	getgeo
 all failed


without DMA, it just works,

Elmer.


