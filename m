Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284781AbRLPUDT>; Sun, 16 Dec 2001 15:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284780AbRLPUDJ>; Sun, 16 Dec 2001 15:03:09 -0500
Received: from [195.66.192.167] ([195.66.192.167]:56073 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S282801AbRLPUDE>; Sun, 16 Dec 2001 15:03:04 -0500
Content-Type: text/plain;
  charset="PT 154"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Caleb Moore <donscarletti@ozemail.com>
Subject: Re: swapping problem on kernel >= 2.4.14
Date: Sun, 16 Dec 2001 22:02:07 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011213204810.A2759@Duron> <01121312062800.02011@manta> <20011215142824.A1306@Duron>
In-Reply-To: <20011215142824.A1306@Duron>
MIME-Version: 1.0
Message-Id: <01121622020701.01821@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 December 2001 01:28, Caleb Moore wrote:

> Ok I checked my system with one swap partition, no swap partitions and a
> swap file. One partition resulted in a crash but after a longer duration
> (two or three times as long. I cannot understand this). A swap file acted
> in a similar way to the single swap. After removing all swap the system
> was as stable as linux is rightly reputed to be.
>
> The kernel does produce an oops when i crash it but for some reason the
> screen blacks out a few minutes later and i am unnable to finish recording
> the sym-debug stuff and cannot get useful information from it. It is not
> logged by klogd and I don't get much further then the registers. The
> message It gives me is unnable to handle kernel paging request at virtual
> address 00015e00 although of course this adress changes.

Sorry, but this info is not enough. Guys most likely won't be able to
fix this if they don't know where your kernel crashed, CPU registers at the 
crash time etc.

Screen blanking: some power-saving? Try to disable.
Maybe you can photograph it if it turns off by itself too fast? :-)
--
vda
