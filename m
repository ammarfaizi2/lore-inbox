Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278673AbRKMUEG>; Tue, 13 Nov 2001 15:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRKMUD5>; Tue, 13 Nov 2001 15:03:57 -0500
Received: from freeside.toyota.com ([63.87.74.7]:33802 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S278660AbRKMUDp>; Tue, 13 Nov 2001 15:03:45 -0500
Message-ID: <3BF17C99.A11BDAA0@lexus.com>
Date: Tue, 13 Nov 2001 12:03:37 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kees <kees@schoen.nl>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: report: tun device
In-Reply-To: <Pine.LNX.4.33.0111131138001.16924-100000@schoen3.schoen.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kees wrote:

> Hi
>
> No I downloaded 2.4.14 and applied patch-2.4.15.pre3

OK, let me rephrase the question:

What kernel version were you running when
vtun last worked?

Also, what version of vtun have you?

cu

jjs

>
>
> Kees
>
> On Tue, 13 Nov 2001, J Sloan wrote:
>
> > kees wrote:
> >
> > > Hi
> > >
> > > I have build 2.4.15pre3 but stil can't use /dev/net/tun (vtund).
> > >
> > >
> > > Nov 13 08:38:29 schoen3 vtund[16676]: Can't allocate tun device. File
> >
> > Did you upgrade from a pre-2.4.6 kernel?
> >
> > mirai.cx: /home/jjs
> > (tty/dev/pts/2): bash: 1003 > uname -a
> > Linux mirai.cx 2.4.15-pre4 #2 Mon Nov 12 22:55:11 PST 2001 i686 GenuineIntel
> > mirai.cx: /home/jjs
> > (tty/dev/pts/2): bash: 1002 > ifconfig tun0
> > tun0      Link encap:Point-to-Point Protocol
> >           inet addr:192.168.111.254  P-t-P:192.168.111.253
> > Mask:255.255.255.255
> >           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1450  Metric:1
> >           RX packets:17 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:10
> >
> >

