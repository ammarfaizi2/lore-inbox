Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267925AbTAHWat>; Wed, 8 Jan 2003 17:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267943AbTAHWat>; Wed, 8 Jan 2003 17:30:49 -0500
Received: from mx3.mail.ru ([194.67.57.13]:43788 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id <S267925AbTAHWas>;
	Wed, 8 Jan 2003 17:30:48 -0500
Date: Wed, 8 Jan 2003 23:37:02 +0100 (CET)
From: Guennadi Liakhovetski <lyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops 2.4.20 + ppp + ide-scsi / usb
In-Reply-To: <Pine.LNX.4.44.0301021137001.10593-100000@poirot.grange>
Message-ID: <Pine.LNX.4.44.0301082320360.1765-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention - the hardware:
an ASUS (A7VI-VM) mobo with the
VIA ProSavage KM133 (VIA VT8365) North and
VT82C686B South bridges,
Duron 900MHz
hda: Maxtor 2B020H1,
hdb: WDC AC21600H,
hdc: 40X12, (BenQ CD/RW "CRW 4012A")
Adaptec 29160 Ultra160 SCSI adapter
PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03

...still hoping for some feedback / encouragement:-) Now that I was trying
to reproduce those Oopses it works rock-stable with the same kernel /
modules:-( whatever I do - ide-scsi read / write with usb-printing and
ppp-transfers, with and without X - conditions that gave me multiple
Oopses when I didn't want them:-) From all the info in these messages, any
idea how to re-trigger them?

Thanks
---
Guennadi Liakhovetski



