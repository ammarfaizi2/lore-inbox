Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310249AbSCKRKl>; Mon, 11 Mar 2002 12:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310279AbSCKRKc>; Mon, 11 Mar 2002 12:10:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2179 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310249AbSCKRKU>; Mon, 11 Mar 2002 12:10:20 -0500
Date: Mon, 11 Mar 2002 12:12:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE on linux-2.4.18
In-Reply-To: <E16kTI9-00016T-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1020311120825.2860A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Alan Cox wrote:

> > hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=1024/255/63, UDMA(33)
> > Partition check:
> >  hda: hda1 hda2 < hda5 hda6 >
> > hd: unable to get major 3 for hard disk
> 
> ^^^^^^^^^^^^^^^^^^
> 
> Case dismissed ;)

I haven't a clue what you are saying. Every IDE option that is allowed
is enabled in .config. The IDE drive(s) are found, but you imply, no
state, that I did something wrong. You state that I haven't enabled
something? I enabled everything that 'make config` allowed me to
enable. Now what is it?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

	Bill Gates? Who?

