Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265364AbRFVS0c>; Fri, 22 Jun 2001 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265408AbRFVS0W>; Fri, 22 Jun 2001 14:26:22 -0400
Received: from calhoun.ci.minneapolis.mn.us ([170.159.4.8]:36484 "EHLO
	calhoun.ci.minneapolis.mn.us") by vger.kernel.org with ESMTP
	id <S265364AbRFVS0E>; Fri, 22 Jun 2001 14:26:04 -0400
Message-ID: <8672A0FE7478D311B75300805FA7F84E45BCD0@200cidtc.ci.minneapolis.mn.us>
From: "Comfort, Dan  W" <Dan.Comfort@ci.minneapolis.mn.us>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: For comment: draft BIOS use document for the kernel
Date: Fri, 22 Jun 2001 13:25:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo?

> If the E820 call fails then the INT 15 AX=0xE801 service is called and the
> results are sanity checked. In particular the code zeroes the CX/DX return
> 
> values in order to detect BIOS implementations that do not set them 
> usable memory data. It also handles older BIOSes that return AX/BX but not
> AX/BX data.
> 
> 
	  /set them usable/set the usable/ 
