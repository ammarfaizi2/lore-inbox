Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSJYN33>; Fri, 25 Oct 2002 09:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSJYN33>; Fri, 25 Oct 2002 09:29:29 -0400
Received: from pop.gmx.de ([213.165.64.20]:28750 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261399AbSJYN32>;
	Fri, 25 Oct 2002 09:29:28 -0400
Message-ID: <001901c27c2a$beb68ae0$6400a8c0@mikeg>
From: "Mike Galbraith" <EFAULT@gmx.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Thomas Molina" <tmolina@cox.net>, <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net><5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net><m18z0os1iz.fsf@frodo.biederman.org><007501c27b37$144cf240$6400a8c0@mikeg> <m1bs5in1zh.fsf@frodo.biederman.org>
Subject: Re: loadlin with 2.5.?? kernels
Date: Fri, 25 Oct 2002 15:30:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Mike Galbraith" <EFAULT@gmx.de>
Cc: "Thomas Molina" <tmolina@cox.net>; <linux-kernel@vger.kernel.org>
Sent: Friday, October 25, 2002 2:21 PM
Subject: Re: loadlin with 2.5.?? kernels


> "Mike Galbraith" <EFAULT@gmx.de> writes:
>
> > (sorry, I have to use this pos at work)
> >
> > Yes.  .31 exploded on me after boot, but did not do the violent
reboot
> > during boot.
>
> Earlier you had said it was .38 or so where the failures kicked in,
> so I figured it was some other problem.

(that was someone else)

> > > If it is really the gdt I have some old patches that roughly do
the
> > > right thing, and I just need to dust them off.
> >
> > You dust them off, and I'll be more than happy to test them.  I keep
> > entirely too many kernels resident to want to use lilo.
>
> Here you are.
> The following patch cleans up and removes unnecessary dependencies
from
> the x86 boot path.

Much appreciated.  I will test/report back.

    -Mike

