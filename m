Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269186AbRHTJZC>; Mon, 20 Aug 2001 05:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270600AbRHTJYx>; Mon, 20 Aug 2001 05:24:53 -0400
Received: from Expansa.sns.it ([192.167.206.189]:23824 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S269186AbRHTJYl>;
	Mon, 20 Aug 2001 05:24:41 -0400
Date: Mon, 20 Aug 2001 11:24:55 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: tristan <fattymikefx@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: installing Linux over a network
In-Reply-To: <20010820012137.8E169501DB@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0108201120520.9856-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ypu can install slackware via NFS, and RH via ftp.
Both procedures are quite aesy and work great.
just export NFS the slakware directory containing the
packages series, and then prepare the canonical two floppy and another
floppy containing the "network" image.

For RH, just put the distribution on a pc where you can access trought
ftp, it does not matter if it is as a regular user or as anonymous.
Pay atention with the correct path to begin RH installation.

Hope you wil be successfull
Luigi

On Sun, 19 Aug 2001, tristan wrote:

> I havent been able to find a way of installing
> Linux slackware or red hat with out using 90 or more
> floppies, and i have no cd rom on my 386. Is there
> a way to install Linux over a network on such an old machine.
> It currently has windows 3.1 and DOS running. And
> has one 60 mb hard drive and one 120 mb hard drive.
> I have found a small easy to install minix 386 that goes over
> DOS so I may just use that to start off, in order to install
> a very old linux kernel .01 or .02
>
> Tristan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

