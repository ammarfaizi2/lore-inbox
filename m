Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131132AbRCJTQq>; Sat, 10 Mar 2001 14:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131139AbRCJTQg>; Sat, 10 Mar 2001 14:16:36 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:7564 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S131132AbRCJTQ2>;
	Sat, 10 Mar 2001 14:16:28 -0500
Message-ID: <3AAA7D5F.A16AA1C7@mirai.cx>
Date: Sat, 10 Mar 2001 11:15:43 -0800
From: J Sloan <jjs@mirai.cx>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.1 on RHL 6.2
In-Reply-To: <001401c0a970$ec3c9b00$1d9509ca@pentiumiii> <200103101754.f2AHsUL04580@mailout1-100bt.midsouth.rr.com> <98drnp$qq0$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:

> Note! You only have to have those symlinks on broken systems such
> as Redhat.

This is silly, Red Hat works fine for a great many people.

He probably removed the original kernel-devel package,
which contained the links above, so they would have to
be remade.

> Sane systems such as Debian have a copy of the kernel header files
> that the C library was compiled against in /usr/include/{linux,asm}

I'm glad you admit that Red Hat is every bit as sane as
debian, since the current shipping version does indeed
have the sort of /usr/include/linux hierarchy you have just
described.

jjs


