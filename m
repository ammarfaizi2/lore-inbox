Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262513AbRENVwm>; Mon, 14 May 2001 17:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262516AbRENVwc>; Mon, 14 May 2001 17:52:32 -0400
Received: from baltazar.tecnoera.com ([200.29.128.1]:46862 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id <S262513AbRENVwT>; Mon, 14 May 2001 17:52:19 -0400
Date: Mon, 14 May 2001 17:51:54 -0400 (CLT)
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec RAID SCSI 2100S
In-Reply-To: <E14zPxu-0001Tr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105141745020.4694-100000@baltazar.tecnoera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Then When I tried to fdisk /dev/sda (/dev/sda is a RAID1 of two
> > Quantum disks) syslog shows this:
>
> is /dev/sda the raid or the disks raw ?

/dev/sda is the RAID1

> > So, I don't know if I'm doing something wrong or what, but I haven't been
> > able to get it working on 2.4.4 yet... please help.
>
> Ok I need to put mroe disks and newer firmware on my card when I have some
> time

my /dev/dsa is a RAID1 made of two quantum atlas 10K II 18.xGb.
Unfortunately I have to get this RAID running this week (maybe on
wednesday) and after that I won't be able to do tests... so.. maybe
I would have to use 2.2.19 instead of 2.4.4  :-(...

Juan Pablo Abuyeres

