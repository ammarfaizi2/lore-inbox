Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312416AbSCYNBW>; Mon, 25 Mar 2002 08:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312418AbSCYNBN>; Mon, 25 Mar 2002 08:01:13 -0500
Received: from cambot.suite224.net ([209.176.64.2]:48908 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S312416AbSCYNAw>;
	Mon, 25 Mar 2002 08:00:52 -0500
Message-ID: <00d101c1d3fd$b8e6bac0$b0d3fea9@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <cooker@linux-mandrake.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E16pUAf-0000Ux-00@the-village.bc.nu>
Subject: Re: [Cooker] (RFC) Supermount 2
Date: Mon, 25 Mar 2002 08:05:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I suspect I'll hear from Juan on this. And I am going to look at your
code...

I realize it will be hard if I start from scratch. Since I was planning to
do it in 2.5.x it will be easier for me to learn how to avoid the problems
that plague the older versions.

Matthew
----- Original Message -----
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: <danny@mailmij.org>
Cc: <cooker@linux-mandrake.com>; <linux-kernel@vger.kernel.org>
Sent: Monday, March 25, 2002 8:05 AM
Subject: Re: [Cooker] (RFC) Supermount 2


> > > 3) Built-in support for packet-writing. ( i.e. insert packet-writing
formatted disk and it loads appropriate kernel modules. )
> > >
> > > There may be other features added if there is an interest in them. I
will need assistance with the packet-writing support. I am only planning to
do this for the 2.5.x and later kernels, so if anyone else wishes to
back-port it to an older kerenl series, by all means do so. I have wanted to
make some kind of contribution to this project for some time and I feel that
this is something that will be useful.
> > >
> > What about doing it in userspace? I remember seeing Alan Cox writing he
> > had a proof of concept of something like this on some ftp server (sorry,
> > cannot remember where).
>
> http://ftp.linux.org.uk/pub/linux/alan - you want volumagic. Its a demo of
> the theory (but quite usable).
>
> Doing supermount in kernel is suprisingly hard, the locking and races you
get
> into are not nice at all - ask Juan about that
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

