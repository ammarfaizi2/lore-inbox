Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310321AbSCLCUQ>; Mon, 11 Mar 2002 21:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310325AbSCLCUF>; Mon, 11 Mar 2002 21:20:05 -0500
Received: from 216-21-153-9.ip.van.radiant.net ([216.21.153.9]:46345 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S310321AbSCLCT7>;
	Mon, 11 Mar 2002 21:19:59 -0500
Date: Mon, 11 Mar 2002 18:50:25 +0000 (/etc/localtime)
From: <gmack@innerfire.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>, andersen@codepoet.org,
        Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8D5ECD.6090108@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0203111849270.28526-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I -do- know the distrinction between hosts and devices.  I think there 
> should be -some- way, I don't care how, to filter out those unknown 
> commands (which may be perfectly valid for a small subset of special IBM 
> drives).  The net stack lets me do filtering, I want to sell you on the 
> idea of letting the ATA stack do the same thing.
> 
> You have convinced me that unconditional filtering is bad.  But I still 
> think people should be provided the option to filter if they so desire.
> 
>     Jeff

How hard would this be to farm off to an external utility?

	Gerhard



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

