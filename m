Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSIICPS>; Sun, 8 Sep 2002 22:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSIICPS>; Sun, 8 Sep 2002 22:15:18 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:22285 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S316258AbSIICPR>; Sun, 8 Sep 2002 22:15:17 -0400
Message-Id: <200209090219.g892Jhm7015294@pincoya.inf.utfsm.cl>
To: jbradford@dial.pipex.com
cc: adamjaskie@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Western Digital hard drive and DMA 
In-Reply-To: Message from jbradford@dial.pipex.com 
   of "Sun, 08 Sep 2002 22:12:14 +0100." <200209082112.g88LCFlI004404@darkstar.example.net> 
Date: Sun, 08 Sep 2002 22:19:43 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbradford@dial.pipex.com said:
> > OK, I have heard that other people have been having this problem for a while 
> > now, but I havent been able to find much about what causes it. I have a 
> > Western Digital hard drive in my computer (60GB, 5400 RPM) I can use it just 
> > fine with no DMA, but it runs much faster with DMA. However, when I use DMA, 
> > all my data is slowly corrupted, and I begin having to re-install packages 
> > all the time. After about a month, my system deteriorates to the point where 
> > I have to reinstall slackware. I have no idea why this is happening, but I 
> > know some people who have had the same experience under Linux with Western 
> > Digital hard drives, but not with other brands. I am assuming this is a 
> > problem with Western Digital's implimentation of DMA, but shouldnt it do 
> > something to prevent errors?
> 
> What is the chipset of the interface it's on?

Use DMA for a week or so, and / is mangled beyond recognition (seems to
happen with read-only access too). Chipset is intel (sr440bx board, PIIX4E
IDE). Have heard of similar problems with DMA on WD drives, but got no
details.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
