Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSLOPkF>; Sun, 15 Dec 2002 10:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSLOPkF>; Sun, 15 Dec 2002 10:40:05 -0500
Received: from sysdoor.net ([62.212.103.239]:32011 "EHLO celia")
	by vger.kernel.org with ESMTP id <S261854AbSLOPkE>;
	Sun, 15 Dec 2002 10:40:04 -0500
Message-ID: <00d601c2a451$519c01c0$3803a8c0@descript>
From: "Vergoz Michael \(SYSDOOR\)" <mvergoz@sysdoor.Com>
To: "Scott Robert Ladd" <scott@coyotegulch.com>,
       "Dave Jones" <davej@codemonkey.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <FKEAJLBKJCGBDJJIPJLJAEICDLAA.scott@coyotegulch.com>
Subject: Re: Kernel for Pentium 4 hyperthreading?
Date: Sun, 15 Dec 2002 16:47:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It's possible to enable HT on any pentium 4, you just have to patch the bios
:P


> Hi,
>
> What I have is, indeed, a hyperthread-enabled Pentium 4. They aren't
common;
> I obtained this one direct from Intel through their Early Access Program.
> The proof in the pudding is that both Windows XP and Linux 2.5.51
recognize
> it as having "two" processors. The motherboard is an Intel Maryville2
(i850E
> chipset), with an option to enable/disable HT on the first BIOS set-up
> screen.
>
> > Note that just because /proc/cpuinfo shows 'ht' does not mean you can
> > use it in hyperthreaded mode. To do that, you also have to have >1
> > sibling in the physical package. Non-Xeon type P4's don't have the
> > extra sibling, so don't function as a hyperthreaded CPU.
>
> Mine does, and so will any 3.06 or 3.6 GHz Pentium 4.
>
> As it is, I'm past the worst of my troubles (knock on wood!) We'll see
what
> happens in the coming days the machine gets stressed. It looks stable with
> 2.5.51 -- so I guess I'm now a Linux kernel beta tester... ;)
>
> Thanks much.
>
> ..Scott
>
> --
> Scott Robert Ladd
> Coyote Gulch Productions,  http://www.coyotegulch.com
> No ads -- just very free (and somewhat unusual) code.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

