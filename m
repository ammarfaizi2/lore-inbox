Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSK0Icr>; Wed, 27 Nov 2002 03:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSK0Icr>; Wed, 27 Nov 2002 03:32:47 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:62108 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261669AbSK0Icq> convert rfc822-to-8bit; Wed, 27 Nov 2002 03:32:46 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.20-rc4-ac1 (also occurs 2.4.20-rc2-ac3) in radeon DRI for XFree86
Date: Wed, 27 Nov 2002 09:39:38 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Joshua Kwan <joshk@mspencer.net>, Arjan van de Ven <arjanv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211270939.38410.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

> Ksymoops output follows.
> I compiled Radeon DRM stuff into the kernel -- i845 agp support from 
> agapgart. I am using gcc-3.2 to compile. 100% reproducible (okay, i've been
> spending too much time on bugzillas...) Feel the power of the oops.

I've posted a similar oops with latest rc2 -AC kernel. I have an ATI Rage128 
card and also got those oops if using DRI.

I hope Arjan may find the bug :)

ciao, Marc
