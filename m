Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbRBVIKH>; Thu, 22 Feb 2001 03:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131321AbRBVIJ5>; Thu, 22 Feb 2001 03:09:57 -0500
Received: from ns2.Deuroconsult.com ([193.226.167.164]:39943 "EHLO
	marte.Deuroconsult.com") by vger.kernel.org with ESMTP
	id <S130815AbRBVIJi>; Thu, 22 Feb 2001 03:09:38 -0500
Date: Thu, 22 Feb 2001 10:09:29 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
To: linux-kernel@vger.kernel.org
Subject: Via UDMA5 3/4/5 is not functional!
Message-ID: <Pine.LNX.4.20.0102221004440.22238-100000@marte.Deuroconsult.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys!

I want to report a problem.

I have an Athlon 900MHz / 256 MB RAM, chipset: VIA VT82c686B, IBM
harddrive (IBM-DTLA-307030).

At first I tried kernel 2.2.16:
	- hdparm -u1 -d1 -X69 /dev/hda => I get 36MB/s

Then I tried kernel 2.4.1. I issued exactly the same hdparm command.
i got in syslog the message: "ide0: Speed warnings UDMA 3/4/5 is not
functional"!

What is the problem?

Thanks in advance!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
A new Linux distribution: http://l13plus.deuroconsult.ro
http://www2.deuroconsult.ro/~catab

