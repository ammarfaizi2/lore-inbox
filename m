Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSIJSAL>; Tue, 10 Sep 2002 14:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSIJSAK>; Tue, 10 Sep 2002 14:00:10 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:21405 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317619AbSIJSAI>; Tue, 10 Sep 2002 14:00:08 -0400
Date: Tue, 10 Sep 2002 20:28:00 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Daniela Engert <dani@ngrt.de>
Cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]][2.4-ac] opti621 can't do dma
In-Reply-To: <200209101716.TAA06198@myway.myway.de>
Message-ID: <Pine.LNX.4.44.0209102026270.1100-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Daniela Engert wrote:

> The Compaq Armada 1530 Notebook has a Opti FireStar chipset with an IDE
> controller which is Ultra DMA capable (but stable only up to MW-DMA
> mode 2). This one *should* be handled by the Linux opti621 driver (I
> don't know if it is).
> 
> Ciao,
>   Dani

I'd be interested to see an lspci, I'd be mortified if the opti621 
driver really drives that controller ;)

	Zwane
-- 
function.linuxpower.ca

