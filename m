Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284973AbRLUSxJ>; Fri, 21 Dec 2001 13:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284972AbRLUSxA>; Fri, 21 Dec 2001 13:53:00 -0500
Received: from [129.27.43.9] ([129.27.43.9]:8458 "EHLO xarch.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S284970AbRLUSws>;
	Fri, 21 Dec 2001 13:52:48 -0500
Date: Fri, 21 Dec 2001 19:52:36 +0100 (CET)
From: Alex <mail_ker@xarch.tu-graz.ac.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: conclusion: arp.c *must* be (still) defective
In-Reply-To: <E16HSWd-0000eY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10112211952010.6988-100000@xarch.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Dec 2001, Alan Cox wrote:

> > Whenever I ping my nexthop router (ip: x.x.x.1) i get a pause of a few
> > seconds, then a whole sequence of "Destination unreachable".
> > Looking at the arp cache using "arp -a", I see that the arp cache is
> > always incomplete (always KEEPS being incomplete). 
> 
> Sounds like you have the card on the wrong port or the IRQ not set in the
> BIOS to be routed to ISA
> 

Sir! It's PLUG AND PLAY! Isapnp! I ought not to care about IRQ or Bios?

Yours

Alex


