Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTASH67>; Sun, 19 Jan 2003 02:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTASH67>; Sun, 19 Jan 2003 02:58:59 -0500
Received: from pop.gmx.de ([213.165.65.60]:43358 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265517AbTASH66>;
	Sun, 19 Jan 2003 02:58:58 -0500
Message-Id: <5.1.1.6.2.20030119090404.00c82030@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sun, 19 Jan 2003 09:04:47 +0100
To: Andrew Morton <akpm@digeo.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.59mm2 BUG at fs/jbd/transaction.c:1148
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030119000548.6a6e26e5.akpm@digeo.com>
References: <5.1.1.6.2.20030119084031.00c81180@pop.gmx.net>
 <20030118002027.2be733c7.akpm@digeo.com>
 <5.1.1.6.2.20030119084031.00c81180@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:05 AM 1/19/2003 -0800, Andrew Morton wrote:
>Mike Galbraith <efault@gmx.de> wrote:
> >
> > Greetings,
> >
> > I got the attached oops upon doing my standard reboot sequence SysRq[sub].
> >
> > fwiw, I was fiddling with an ext2 ramdisk just prior to poking buttons.
> >
>
>You using data=journal?

Yup, on /var.

         -Mike

