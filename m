Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319100AbSHSXDb>; Mon, 19 Aug 2002 19:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319102AbSHSXDa>; Mon, 19 Aug 2002 19:03:30 -0400
Received: from 0xc3d7fc80.boanxx2.adsl.tele.dk ([195.215.252.128]:56963 "EHLO
	idoru") by vger.kernel.org with ESMTP id <S319100AbSHSXDa>;
	Mon, 19 Aug 2002 19:03:30 -0400
Subject: Re: More VIA chipset fun?
From: Martin Hammer <martin.h@subdimension.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Aug 2002 01:07:33 +0200
Message-Id: <1029798454.1906.24.camel@idoru>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the exact same symptoms, although our systems are somewhat
different (still the VIA vt8233A southbridge, though):

Intel Pentium 4 2000Mhz (Northwood core) 
Soltek SL-85DRV3 motherboard w. VIA P4X266A chipset 
Nvidia GeForce 2 GTS and SB Live
256MB DDR RAM 
Kernel 2.4.19 w. XFS and pre-empt patches + Alsa 0.9 modules

I tried disabling both audio-support, rtc-driver and apm, but the
lockup's still occur.

PS. Pleace cc me, as I'm not on the list. 




