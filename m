Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273682AbRIQUMd>; Mon, 17 Sep 2001 16:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273674AbRIQUMX>; Mon, 17 Sep 2001 16:12:23 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:32427 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S273675AbRIQUMH>;
	Mon, 17 Sep 2001 16:12:07 -0400
Message-Id: <m15j4kj-000QJQC@amadeus.home.nl>
Date: Mon, 17 Sep 2001 21:12:25 +0100 (BST)
From: arjan@fenrus.demon.nl
To: garrett@garrettm.com
Subject: Re: HPT370
cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109172006.f8HK6TO01234@archimedes.garrettm.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200109172006.f8HK6TO01234@archimedes.garrettm.com> you wrote:
> I'm unsure of who maintains the driver for the hpt370 ide raid card, but was 
> wondering if anyone knows when (or if) it will support raid sets instead of 
> just single disks. 

Recent 2.4.X-ac kernels already support it in RAID0 mode; you can also get
the standalone driver from

http://people.redhat.com/arjanv/pdcraid/

