Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTDPP3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTDPP3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:29:46 -0400
Received: from h007.c000.snv.cp.net ([209.228.32.71]:28606 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S264498AbTDPP3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:29:44 -0400
X-Sent: 16 Apr 2003 15:41:37 GMT
Message-ID: <003801c3042e$a6bcbea0$6901a8c0@athialsinp4oc1>
From: "Brien" <admin@brien.com>
To: "John Bradford" <john@grabjohn.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200304161511.h3GFBoe7000614@81-2-122-30.bradfords.org.uk>
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
Date: Wed, 16 Apr 2003 11:41:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

(Thanks for replying, John.)

I ran Memtest86, and there're 290 errors that showed up from test 7. But the
thing that I don't understand is, if I use either of the RAM modules alone,
Linux loads and runs perfectly for as long as I've tried; Could it possibly
be a problem with something besides the RAM (e.g. motherboard, CPU)? And I
still don't know if my RAM setup is even supported by Linux -- I'm guessing
that it is though (?).

----- Original Message -----
From: "John Bradford" <john@grabjohn.com>
To: "Brien" <admin@brien.com>
Sent: Wednesday, April 16, 2003 11:11 AM
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro


> > I have a Gigabyte SINXP1394 motherboard, and 2 Kingston 512 MB DDR 400
(CL
> > 2.5) RAM modules installed. Whenever I try to install any Linux
> > distribution, I always get a black screen after the kernel loads
>
> Can you run Memtest86 on it for an hour or two, and confirm that there
> is nothing wrong with the memory?  Sometimes really obscure faults
> happen to get triggered with Linux, even if the machine appears to
> work with other operating systems.
>
> (By the way, good choice getting a Gigabyte board, I always use them,
> and never have problems with them).
>
> John.
>
>


