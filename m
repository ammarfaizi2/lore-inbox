Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265346AbSIWKLn>; Mon, 23 Sep 2002 06:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265349AbSIWKLn>; Mon, 23 Sep 2002 06:11:43 -0400
Received: from jack.stev.org ([217.79.103.51]:52134 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id <S265346AbSIWKLm>;
	Mon, 23 Sep 2002 06:11:42 -0400
Message-ID: <017801c262eb$010a3d00$0cfea8c0@ezdsp.com>
From: "James Stevenson" <james@stev.org>
To: "Kernel" <linux-kernel@vger.kernel.org>
Subject: via82cxxxx.c ?
Date: Mon, 23 Sep 2002 11:21:38 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i have the following on motherboard card.

 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio
Controller (rev 48).

there appears ot be a driver for it. But i am havign a few problems with it
when the driver loads it says it picks the card up no problem
and stays loaded and has the ioports, irq in /proc/*

but when trying to open /dev/audio or /dev/dsp or /dev/mixer
all i get back is a -ENODEV

does anyone know where i could get the docs on the card and have
ago at fixing the driver ? is there a maintiner / active people
working on the driver ?

i currently also have the via drivers working on it but they
tend to work / not work and work a bit of the time and of course
these taint my kernel :(

thanks
    James


