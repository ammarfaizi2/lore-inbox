Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUCHDig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 22:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUCHDie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 22:38:34 -0500
Received: from a213-22-119-56.netcabo.pt ([213.22.119.56]:34457 "HELO
	rootisg0d.org") by vger.kernel.org with SMTP id S262195AbUCHDib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 22:38:31 -0500
Message-ID: <000801c404be$ca7bb9e0$0700a8c0@darkgod>
From: "psycosonic" <psycosonic@rootisg0d.org>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: kernel 2.4.25 and SIS900 ethernet card ... ((( update )))
Date: Mon, 8 Mar 2004 03:38:15 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2055
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well .. i've tried now with a realtek.. the problem persists.
What should i do? i've already recompiled the kernel too many times... same 
options that 2.4.24...
2.4.24 works fine with network.. but 2.4.25 don't :(
Help me please.

Thanks
.

----- Original Message ----- 
From: "psycosonic" <psycosonic@rootisg0d.org>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, February 28, 2004 3:11 AM
Subject: Fw: kernel 2.4.25 and SIS900 ethernet card


>
>
> Hey.
>
> I'm having some problems since i updated from kernel 2.4.24 to 2.4.25 .. 
> it seems that 2.4.25 has some incompatibility with SIS900 ethernet card. 
> Well it should work @ 100Mbit .. and it only works @ 10Mbit... i've used 
> mii-tool to diagnose the problem.. what i got was this:
>
> root@XXX:~# mii-tool
> eth0: negotiated 100baseTx-FD, link ok
> eth1: negotiated 100baseTx-FD, link ok <--- this is the one i'm talkin' 
> about ( SIS900 )
>
>
> ...
> 00:0e.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
> 10/100 Ethernet (rev 02)
> ...
>
>
> --------
>
> Well.. with kernel 2.4.24 i usually had a max speed of 12Mb/s .. now , 
> with 2.4.25 it only goes to 2,2Mb/s :(
>
> What should i do ? i've already tried to compile the driver from SIS but 
> it's the same.
>
> I'll be waiting for an answer.
> Thanks.
>
> Hope this is useful :)
>
> Cya m8's * *
> 


