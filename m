Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310417AbSCKRRv>; Mon, 11 Mar 2002 12:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310382AbSCKRRd>; Mon, 11 Mar 2002 12:17:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41227 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310443AbSCKRQK>; Mon, 11 Mar 2002 12:16:10 -0500
Subject: Re: IDE on linux-2.4.18
To: root@chaos.analogic.com
Date: Mon, 11 Mar 2002 17:31:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <Pine.LNX.3.95.1020311120825.2860A-100000@chaos.analogic.com> from "Richard B. Johnson" at Mar 11, 2002 12:12:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kTe7-0001AU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  hda: hda1 hda2 < hda5 hda6 >
> > > hd: unable to get major 3 for hard disk
> > 
> > ^^^^^^^^^^^^^^^^^^
> > 
> > Case dismissed ;)
> 
> I haven't a clue what you are saying. Every IDE option that is allowed
> is enabled in .config. The IDE drive(s) are found, but you imply, no

You have the old hd driver enabled which is what caused your problem
