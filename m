Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316799AbSF0MVM>; Thu, 27 Jun 2002 08:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSF0MVL>; Thu, 27 Jun 2002 08:21:11 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:21156 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S316799AbSF0MVK>; Thu, 27 Jun 2002 08:21:10 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E11411@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Multiple profiles
Date: Thu, 27 Jun 2002 15:19:12 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I wonder if somebody is familiar with the way to create 
>multiple hardware configurations (profiles) on Linux? 

Sorry for not being clear enough. I got several replies saying that this is
not a kernel list question, I suppose because of the example with the
network. In reality, this problem is much broader...

One might think of external devices (tapes, scaners, disks, etc.) constanly
being moved from machine to machine. I understand I can twist /etc/init.d/*
to support all the configurations. However, I don't see a reason why it
cannot be the responsibility of Linux kernel to "see" different hardware
configurations on boot.

>From the replies I got, I understand that Linux kernel doesn't provide such
functionality. That's all I wanted to know.

Best,
Giga
P.S. BTW, I needed this for RH distribution.
