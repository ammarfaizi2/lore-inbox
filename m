Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262853AbRE0SPg>; Sun, 27 May 2001 14:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262855AbRE0SP0>; Sun, 27 May 2001 14:15:26 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:37449 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S262853AbRE0SPP>; Sun, 27 May 2001 14:15:15 -0400
Message-ID: <011501c0e6d8$ec93af80$4aa6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
Cc: <stepken@little-idiot.de>, <linux-kernel@vger.kernel.org>,
        "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <01052622193100.01317@linux.zuhause.de> <00a101c0e642$4f0791a0$52a6b3d0@Toshiba> <20010527183207.B21206@unthought.net>
Subject: Re: IDE Performance lack !
Date: Sun, 27 May 2001 11:14:50 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jakob Østergaard" <jakob@unthought.net> wrote :
>
> The answer for both of you is:
>
>   hdparm -d1 /dev/hd{whatever}
>
> Without DMA enabled, performance is going to suck.  1.9 MB/sec is actually
pretty
> good without DMA   ;)
>

i think DMA or PCI is not my solution , atleast :)

Thank you,

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.


