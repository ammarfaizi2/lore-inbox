Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135506AbREHVQl>; Tue, 8 May 2001 17:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135491AbREHVQb>; Tue, 8 May 2001 17:16:31 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:10432 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S135363AbREHVQR>;
	Tue, 8 May 2001 17:16:17 -0400
Message-Id: <m14xEq1-000OWpC@amadeus.home.nl>
Date: Tue, 8 May 2001 22:16:09 +0100 (BST)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: bergsoft@home.com (Seth Goldberg)
Subject: Re: Athlon and fast_page_copy: What's it worth ? :)
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <E14vmpN-000822-00@the-village.bc.nu> <006e01c0d4e9$3c0bd210$0300a8c0@methusela> <20010504172657.B14969@debian.org> <20010505155113.D29451@metastasis.f00f.org> <3AF37CD6.17677C56@home.com> <20010505163204.A29622@metastasis.f00f.org> <3AF389BD.81F9B398@home.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3AF389BD.81F9B398@home.com> you wrote:
> Hi,

>   Before I go any further with this investigation, I'd like to get an
> idea
> of how much of a performance improvement the K7 fast_page_copy will give
> me.
> Can someone suggest the best benchmark to test the speed of this
> routine?

http://www.fenrus.demon.nl/athlon.c

is a userspace benchmark of the current code vs C etc
