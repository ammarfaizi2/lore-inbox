Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293056AbSBWAWO>; Fri, 22 Feb 2002 19:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293055AbSBWAWE>; Fri, 22 Feb 2002 19:22:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59145 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293053AbSBWAVw>; Fri, 22 Feb 2002 19:21:52 -0500
Subject: Re: 2.4.17: oops in kapm-idled?   (on IBM Thinkpad A30P [2653-66U])
To: beh@icemark.net (Benedikt Heinen)
Date: Sat, 23 Feb 2002 00:36:02 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jdthood@mail.com (Thomas Hood),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202222133570.1183-100000@berenium.icemark.ch> from "Benedikt Heinen" at Feb 22, 2002 09:43:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16eQAU-0003de-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't switch off all individual devices in the notebook, but if I
> use the prism2 driver from linux-wlan.com, I can't get the full
> performance out of it - but just something like ~20kb/s throughput
> in ftp  (Win2K gets more than 500kb/s)...

What happens if you use the in kernel pcmcia, and the in kernel prism 
chipset drivers ?
