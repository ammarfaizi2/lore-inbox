Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262091AbSIYTyT>; Wed, 25 Sep 2002 15:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262092AbSIYTyT>; Wed, 25 Sep 2002 15:54:19 -0400
Received: from tuxick.xs4all.nl ([213.84.143.98]:33801 "HELO tuxick.net")
	by vger.kernel.org with SMTP id <S262091AbSIYTyS>;
	Wed, 25 Sep 2002 15:54:18 -0400
Date: Wed, 25 Sep 2002 21:59:33 +0200 (CEST)
From: Tony den Haan <tony@tuxick.net>
To: linux-kernel@vger.kernel.org
Subject: usb-storage + F601Z drives scsi mad
Message-ID: <Pine.LNX.4.21.0209252148580.12550-100000@kleintje.nozone.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

when i connect digital camera fuji finepix F601Z and modprobe usb-storage
my scsi drives go mad, kinda like make -j during updatedb.

this only happens when cam is connected, the module by itself doesn't 
cause any trouble.

kernel 2.4.19
gcc-3.2
latest 'stable' vanilla make, binutils etc..

tekram DC-390UW using SYM53C8XX
on SMP PIII with VIA set

if any others find similar problems, it might be worth a bugreport?

tony

