Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293214AbSBWVa7>; Sat, 23 Feb 2002 16:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293213AbSBWVav>; Sat, 23 Feb 2002 16:30:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11024 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293214AbSBWVak>; Sat, 23 Feb 2002 16:30:40 -0500
Subject: Re: Promise 20269 support?
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Sat, 23 Feb 2002 21:45:10 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0202232223590.13846-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Feb 23, 2002 10:25:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ejyh-0006Bi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > With luck 2.4.19
> 
> What's the problem with it? I've been using the current one for a couple
> of months without any problems, and I have tested it with a
> half-a-terabyte RAID-0 with really high load. It's never let me down...

Its just a matter of timing. Its been tested a fair bit in -ac now, and is
looking very good, but Marcelo is going to delete any submission like that
for 2.4.18-rc, and rightfully so
