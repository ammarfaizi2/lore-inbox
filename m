Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292359AbSB0PDq>; Wed, 27 Feb 2002 10:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292549AbSB0PDf>; Wed, 27 Feb 2002 10:03:35 -0500
Received: from mark.staudinger.net ([207.252.75.224]:16654 "EHLO
	mark.staudinger.net") by vger.kernel.org with ESMTP
	id <S292542AbSB0PD2>; Wed, 27 Feb 2002 10:03:28 -0500
Message-Id: <200202271514.g1RFEnoX065760@mark.staudinger.net>
Date: Wed, 27 Feb 2002 15:14:49 -0000
To: <linux-kernel@vger.kernel.org>
Subject: Linux 2.4 on VIA VT8601T chipset?
From: "Mark Staudinger" <mark@staudinger.net>
X-Mailer: TWIG 2.6.2
Reply-To: mark@staudinger.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are there any known problems with this particular VIA chipset, or VIAs in 
general?  I'm noticing extremely slow disk access on boot.  Haven't run any 
benchmarks against my other MBs (which all have Intel chipsets), but the 
"loading kernel...." stage is noticeably slower, and fsck takes about 3-4 
times as long as it does on other MBs.  I'm running kernel 2.4.17.

Thanks....
-Mark
