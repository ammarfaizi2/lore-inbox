Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287804AbSANReW>; Mon, 14 Jan 2002 12:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287838AbSANReQ>; Mon, 14 Jan 2002 12:34:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31493 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287804AbSANReA>; Mon, 14 Jan 2002 12:34:00 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Mon, 14 Jan 2002 17:42:03 +0000 (GMT)
Cc: davidsen@tmr.com (Bill Davidsen), andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <E16QAAG-0000mo-00@starship.berlin> from "Daniel Phillips" at Jan 14, 2002 05:40:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QB7T-0002JS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > stays on.  That's another problem, and I did play with some patches this
> > weekend without making myself really happy :-( Another topic,
> > unfortunately.
> 
> Patience, the problem is understood and there will be a fix in the 2.5 
> timeframe.

Without a fix in the 2.4 timeframe everyone has to run 2.2. That strikes
me as decidedly non optimal. If you are having VM problems try both the
Andrea -aa and the Rik rmap-11b patches (*not together*) and report back
