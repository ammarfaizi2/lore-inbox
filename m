Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281592AbRKMKk6>; Tue, 13 Nov 2001 05:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281595AbRKMKki>; Tue, 13 Nov 2001 05:40:38 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:22460 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S281591AbRKMKkT>; Tue, 13 Nov 2001 05:40:19 -0500
Date: Tue, 13 Nov 2001 11:38:32 +0100 (CET)
From: kees <kees@schoen.nl>
To: J Sloan <jjs@pobox.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: report: tun device
In-Reply-To: <3BF0EE24.7661D843@pobox.com>
Message-ID: <Pine.LNX.4.33.0111131138001.16924-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

No I downloaded 2.4.14 and applied patch-2.4.15.pre3

Kees

On Tue, 13 Nov 2001, J Sloan wrote:

> kees wrote:
>
> > Hi
> >
> > I have build 2.4.15pre3 but stil can't use /dev/net/tun (vtund).
> >
> >
> > Nov 13 08:38:29 schoen3 vtund[16676]: Can't allocate tun device. File
>
> Did you upgrade from a pre-2.4.6 kernel?
>
> mirai.cx: /home/jjs
> (tty/dev/pts/2): bash: 1003 > uname -a
> Linux mirai.cx 2.4.15-pre4 #2 Mon Nov 12 22:55:11 PST 2001 i686 GenuineIntel
> mirai.cx: /home/jjs
> (tty/dev/pts/2): bash: 1002 > ifconfig tun0
> tun0      Link encap:Point-to-Point Protocol
>           inet addr:192.168.111.254  P-t-P:192.168.111.253
> Mask:255.255.255.255
>           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1450  Metric:1
>           RX packets:17 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>
>

