Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271981AbRIVT05>; Sat, 22 Sep 2001 15:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271982AbRIVT0r>; Sat, 22 Sep 2001 15:26:47 -0400
Received: from ams8uucp0.ams.ops.eu.uu.net ([212.153.111.69]:37515 "EHLO
	ams8uucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S271981AbRIVT0e>; Sat, 22 Sep 2001 15:26:34 -0400
Date: Sat, 22 Sep 2001 21:12:46 +0200 (CEST)
From: kees <kees@schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: FYI, SMP crash with 2.4.10pre12
Message-ID: <Pine.LNX.4.33.0109222109370.5027-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I experience an reproducable total lockup with SMP 2.4.10pre12.
This happens when I start camstream for my USB Philips webcam.
This doesn't happen with 2.4.8, I'll try bare 2.4.9 later.
Dual PIII (no OC) on MSI694D mobo with 128MB .

Kees

