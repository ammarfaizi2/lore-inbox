Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSLLRyU>; Thu, 12 Dec 2002 12:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSLLRyU>; Thu, 12 Dec 2002 12:54:20 -0500
Received: from fw1.afb.de ([195.30.9.122]:42197 "EHLO fw1.afb.de")
	by vger.kernel.org with ESMTP id <S264920AbSLLRyT>;
	Thu, 12 Dec 2002 12:54:19 -0500
Message-ID: <2F4E8F809920D611B0B300508BDE95FE29444E@AFB91>
From: BoehmeSilvio <Boehme.Silvio@afb.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-ac1 KT400 AGP support
Date: Thu, 12 Dec 2002 19:04:02 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-Scanner: exiscan *18MXeg-0006O6-00*QKsBrlIOUJk* on Astaro Security Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Hopefully I'm right here.....

I have some trouble to get agpgart working in kernel 2.4.20-ac1.

My setup:
- ASUS A7V8X with VIA KT400 Chip (AGP 8X)
- ATI Radeon 9700 PRO (also AGP 8X)

The original 2.4.20 kernel doesn't know this chipset, so I tried the
2.4.20-ac1, which has some patches for the KT400.

With 2.4.20-ac1 I get the following error:

agpgart: Maximum main memory to use for agp memory: 690M
agpgart: Detected Via Apollo KT-400 chipset
agpgart: unable to determine aperture size

By

Silvio
