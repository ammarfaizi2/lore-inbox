Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262817AbSI3SH6>; Mon, 30 Sep 2002 14:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262818AbSI3SH5>; Mon, 30 Sep 2002 14:07:57 -0400
Received: from [209.194.14.2] ([209.194.14.2]:21767 "EHLO ecity.ecity.org")
	by vger.kernel.org with ESMTP id <S262817AbSI3SH4>;
	Mon, 30 Sep 2002 14:07:56 -0400
Message-ID: <2a1a01c268ad$0d35b650$250bc2d1@pent>
From: "Jeff Willis" <jeff@e-city.com>
To: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290716.g8T7GNwf000562@darkstar.example.net> <20020929091229.GA1014@suse.de> <1033311400.13001.5.camel@irongate.swansea.linux.org.uk> <20020929153817.GC1014@suse.de>
Subject: Re: v2.6 vs v3.0
Date: Mon, 30 Sep 2002 14:13:15 -0400
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Most of my boxes won't even run a 2.5 tree yet. I'm sure its hardly
> > unique. Middle of November we may begin to find out how solid the core
> > code actually is, as drivers get fixed up and also in the other
> > direction as we eliminate numerous crashes caused by "fixed in 2.4" bugs

You're right, it's not unique.  Will they run 2.4?  I've got about a dozen
boxes that have had over a year uptime with 2.0 or 2.2, but won't boot with
the 2.4 or the recent 2.5 I tried.

> Well why don't they run with 2.5?

Good question.  With the 2.4 kernels I've tried zImages worked fine but
bzImages wouldn't boot.   Unfortunately, with the options I need, the kernel
won't fit in a zImage.  The servers were all originally AMI motherboards,
but after replacing a few due to failures, there's a few Abit, Tyans and
Gigabyte replacements.  The Gigabyte (model GA-8IRXP, I think) will boot
bzImages, but I hate to replace motherboards that have worked fine for years
just to boot the new 2.6/3.0.


