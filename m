Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTBXJ6Q>; Mon, 24 Feb 2003 04:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTBXJ6P>; Mon, 24 Feb 2003 04:58:15 -0500
Received: from daimi.au.dk ([130.225.16.1]:26512 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S266095AbTBXJ6P>;
	Mon, 24 Feb 2003 04:58:15 -0500
Message-ID: <3E59EF0F.2C731C06@daimi.au.dk>
Date: Mon, 24 Feb 2003 11:08:15 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Toplica Tanaskovi? <toptan@EUnet.yu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Panic in i810
References: <3E595ED3.5D86FE45@daimi.au.dk> <200302240250.42872.toptan@EUnet.yu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toplica Tanaskovi? wrote:
> 
> Dana ponedeljak 24. februar 2003. 00:52, Kasper Dupont je napisao/la:
> > I have a reproducable kernel panic with different 2.4.x kernels.
> > I'm using XFree86-4.2.0-8 with a i810 onboard chipset. Sometimes
> > when I log off X the kernel panics. This can be reproduced by
> > loging in on a VC as root and typing:
> 
>         Have you tried my latest backport for agpgart from 2.5 to 2.4.21-pre4.

No. I notice some talk about that backport, but I see no patch.
Where can I find it?

>         If you did not, try it. I do not suggest that it will work correctly with
> your configuration (you did not mention which graphics card you own).

All I know is that the PC is a model called "F@MILY net PC" and
has onboard i810. How do I find more relevant informations?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
