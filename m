Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318802AbSHWNRV>; Fri, 23 Aug 2002 09:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318804AbSHWNRV>; Fri, 23 Aug 2002 09:17:21 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:21511 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S318802AbSHWNRU>; Fri, 23 Aug 2002 09:17:20 -0400
Message-ID: <006901c24aa8$506124a0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Omar" <omar@natasha.org>, <linux-kernel@vger.kernel.org>
References: <OFE708D02D.C1935D57-ON85256C1D.006DDF9E@pok.ibm.com> <001f01c24a31$d4956a50$493e1f7e@IRV429>
Subject: Re: serial driver maintaner
Date: Fri, 23 Aug 2002 09:23:48 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Omar" <omar@natasha.org>
> I've been trying to find out information on the Linux serial driver.  The
> maintainer hasn't updated his web site in a long time, does anyone know if
> he's still maintaining it ??

Ted doesn't seem to be maintaining it anymore. If you look in the
linux-kernel archive you'll find that Russell King is doing a rewrite
for 2.5/6 anyway.

> I am asking because I have a uart that isn't directly supported in the
> driver and I may need to add support for it, but I don't want to modify
the
> serial driver unless it can be included in the main distribution channel.

Update the driver, make a patch and send it to the list. If it's good
likely it will be included.

You may want to check out linux-serial also.

..Stu


