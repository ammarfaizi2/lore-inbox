Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285912AbRLHLVK>; Sat, 8 Dec 2001 06:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285909AbRLHLVA>; Sat, 8 Dec 2001 06:21:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39685 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285912AbRLHLUs>; Sat, 8 Dec 2001 06:20:48 -0500
Subject: Re: Oops report for 2.2.19(ext3)
To: bhalla@uiuc.edu
Date: Sat, 8 Dec 2001 11:29:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112080027.fB80Rra03466@a-night-at-the-opera.cu.groogroo.com> from "Arun Bhalla" at Dec 07, 2001 06:27:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Cfg6-000185-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For at least a few months, if not most of the past year, my system
> hasn't had an uptime longer than 14 days or so.  Every so often,

> (which has the same model of CPU and motherboard).  However, his
> production server running 2.2.19 with slightly different hardware has
> an uptime of 220 days.  I thought I'd finally send in an Oops report

That should be a clue. If you are using an AMD processor on a VIA chipset
you may be hitting chipset bugs for one.

> since work towards 2.2.20 appears to have been abandoned.  I have other

2.2.20 was released ages ago
