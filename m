Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266400AbRGBIFx>; Mon, 2 Jul 2001 04:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266401AbRGBIFm>; Mon, 2 Jul 2001 04:05:42 -0400
Received: from prograine2.raster.krakow.pl ([212.160.153.165]:45202 "EHLO
	procomnet2.prograine.net") by vger.kernel.org with ESMTP
	id <S266400AbRGBIFa>; Mon, 2 Jul 2001 04:05:30 -0400
Date: Mon, 2 Jul 2001 10:11:00 +0200 (CEST)
From: <pt@procomnet2.prograine.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Intel SRCU3-1 RAID (I2O) and 2.4.5-ac18
Message-ID: <Pine.LNX.4.33.0107021001060.20976-100000@procomnet2.prograine.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you can repeat it in 2.4.5 let me know.

Yes, I can reproduce it in 2.4.5 with exactly the same behaviour and
messages. I made another experiment by installing RH7.1 directly
on the raid partition (it was not possible to install with my mobo
before because of a problem in the RH installer) and I couldn't
reproduce the problem in 2.4.2 supplied by RedHat.

> ALso set up the i2o cgi tools and see why
> the device wants to talk to you

Tried to setup the Intel tools just as I did it before and I get
only an "Error: could not open I2O system" in the browser under the
RH-supplied kernel. I will keep trying to resolve this problem.

greetings

Przemek Tomala

