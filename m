Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318336AbSG3QJP>; Tue, 30 Jul 2002 12:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318337AbSG3QJP>; Tue, 30 Jul 2002 12:09:15 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:270 "EHLO avscan1.sentex.ca")
	by vger.kernel.org with ESMTP id <S318336AbSG3QJN>;
	Tue, 30 Jul 2002 12:09:13 -0400
Message-ID: <013301c237e4$1bb345c0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: "Matthew Wilcox" <willy@debian.org>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <20020729181702.E25451@flint.arm.linux.org.uk> <20020729231927.D3317@parcelfarce.linux.theplanet.co.uk> <008801c237d6$8b7dc640$294b82ce@connecttech.com> <20020730161940.P1441@parcelfarce.linux.theplanet.co.uk> <00f801c237df$d09d4e40$294b82ce@connecttech.com> <20020730165351.C7677@flint.arm.linux.org.uk>
Subject: Re: [parisc-linux] 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Date: Tue, 30 Jul 2002 12:06:53 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Russell King" <rmk@arm.linux.org.uk>
> To be able to suck in USB (and some of the other drivers), two changes
> need to be made to the core:
>
> 2. USB devices want "packets" of data to write rather than the ring-
>    buffer we currently use for UARTs.

This currently isn't a problem I don't think.

> (time to start ebaying for USB serial devices...)

I can see about getting you one of our boards on eval. I'd need a
brief "business justification".

..Stu

--
We make multiport serial boards.
<http://www.connecttech.com>
(800) 426-8979


