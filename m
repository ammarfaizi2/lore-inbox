Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285906AbRLHLC0>; Sat, 8 Dec 2001 06:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285907AbRLHLCQ>; Sat, 8 Dec 2001 06:02:16 -0500
Received: from h217n3fls22o974.telia.com ([213.64.105.217]:45030 "EHLO
	milou.dyndns.org") by vger.kernel.org with ESMTP id <S285906AbRLHLCI>;
	Sat, 8 Dec 2001 06:02:08 -0500
Message-Id: <200112081102.fB8B26o29842@milou.dyndns.org>
X-Mailer: exmh version 2.5_20010923 01/15/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: ide_dmaproc & apm 
From: Anders Eriksson <aer-list@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 12:02:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've got my laptop's bios set to suspend-to-disk. During a mpg123 
session it suspended and when resumed, I got 2 seconds of audio 
followed by 10 sec silence, followed by

hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14


The disk light was on and I had to power cycle it.


What gives?

/Anders 

