Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269084AbTBXCRW>; Sun, 23 Feb 2003 21:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269085AbTBXCRW>; Sun, 23 Feb 2003 21:17:22 -0500
Received: from smtp2.EUnet.yu ([194.247.192.51]:56500 "EHLO smtp2.eunet.yu")
	by vger.kernel.org with ESMTP id <S269084AbTBXCRW>;
	Sun, 23 Feb 2003 21:17:22 -0500
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@EUnet.yu>
To: Kasper Dupont <kasperd@daimi.au.dk>
Subject: Re: Panic in i810
Date: Mon, 24 Feb 2003 02:50:42 +0100
User-Agent: KMail/1.5
References: <3E595ED3.5D86FE45@daimi.au.dk>
In-Reply-To: <3E595ED3.5D86FE45@daimi.au.dk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Message-Id: <200302240250.42872.toptan@EUnet.yu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by smtp2.eunet.yu id h1O2RWF31079
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana ponedeljak 24. februar 2003. 00:52, Kasper Dupont je napisao/la:
> I have a reproducable kernel panic with different 2.4.x kernels.
> I'm using XFree86-4.2.0-8 with a i810 onboard chipset. Sometimes
> when I log off X the kernel panics. This can be reproduced by
> loging in on a VC as root and typing:

	Have you tried my latest backport for agpgart from 2.5 to 2.4.21-pre4.
	If you did not, try it. I do not suggest that it will work correctly with 
your configuration (you did not mention which graphics card you own). I've 
tested it with ATI Radeon R9000 and GeForce 2MX400 on Abit(i810) mobo. And 
everything worked fine.
-- 
Pozdrav,
Tanasković Toplica


