Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129958AbRCGUEn>; Wed, 7 Mar 2001 15:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRCGUEd>; Wed, 7 Mar 2001 15:04:33 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:26756 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S129958AbRCGUEW>;
	Wed, 7 Mar 2001 15:04:22 -0500
Date: Wed, 7 Mar 2001 21:03:49 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: can't read DVD (under 2.4.[12] & 2.2.17)
Message-ID: <Pine.GSO.4.30.0103072059180.29959-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,

Whatever I tried, I couldn't get my DVDs read. I get:
 sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
or, I don't use ide-scsi, i get the ATAPI equivalent.
I have udf support compiled in, i have successfully authenticated the
disk(s), but lo luck.

The drive is:
   Vendor: PIONEER   Model: DVD-ROM DVD-105   Rev: 1.22

I tried 2.2.17, 2.4.1 & 2.4.2 (and a few different compiled versions of
them)

What might be the problem?

Balazs Pozsar.

