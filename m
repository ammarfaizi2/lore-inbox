Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312417AbSDEJUB>; Fri, 5 Apr 2002 04:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312419AbSDEJTu>; Fri, 5 Apr 2002 04:19:50 -0500
Received: from Expansa.sns.it ([192.167.206.189]:13318 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S312417AbSDEJTk>;
	Fri, 5 Apr 2002 04:19:40 -0500
Date: Fri, 5 Apr 2002 11:19:25 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: brian@worldcontrol.com, <linux-kernel@vger.kernel.org>
Subject: Re: raid,apm,ide, powers down too fast & corrupts raid
In-Reply-To: <E16tD02-0006bw-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0204051118120.13866-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Apr 2002, Alan Cox wrote:

> > I'm running Linux 2.4.18 on this system.  Has this problem been
> > addressed in any later versions?
>
> If the box is IDE then current 2.4.19pre/2.4.19-ac trees actually send
> flush commands to the IDE disks to be sure its cleared everything out. It
> might be that.

Does that work well with disk cache?
(incidentally, I do not have actually IDE disks out of production, so I
cannot test)

Luigi



