Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSHYKnN>; Sun, 25 Aug 2002 06:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSHYKnN>; Sun, 25 Aug 2002 06:43:13 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:33207 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317181AbSHYKnM>; Sun, 25 Aug 2002 06:43:12 -0400
Date: Sun, 25 Aug 2002 13:04:10 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: joerg.beyer@email.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: <no subject>
In-Reply-To: <200208250915.g7P9FvX01623@mailgate5.cinetic.de>
Message-ID: <Pine.LNX.4.44.0208251302520.28574-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Aug 2002 joerg.beyer@email.de wrote:

> Disk access, like untaring a big tar file (e.g. kernel sources)
> are really slow.

> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> hda: HITACHI_DK23DA-20, ATA DISK drive
> hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63
> hdc: ATAPI 24X DVD-ROM drive, 512kB Cache

You seem to be running without DMA.

	Zwane
-- 
function.linuxpower.ca


