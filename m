Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSIJRLi>; Tue, 10 Sep 2002 13:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSIJRLi>; Tue, 10 Sep 2002 13:11:38 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:26897 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S316845AbSIJRLi>; Tue, 10 Sep 2002 13:11:38 -0400
Message-Id: <200209101716.TAA06198@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Andre Hedrick" <andre@linux-ide.org>,
       "Zwane Mwaikambo" <zwane@mwaikambo.name>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Date: Tue, 10 Sep 2002 19:16:09 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <Pine.LNX.4.44.0209101920260.1100-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH]][2.4-ac] opti621 can't do dma
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002 19:22:41 +0200 (SAST), Zwane Mwaikambo wrote:

>	afaik the opti621 can't do DMA, also aren't they all addon cards?

The Compaq Armada 1530 Notebook has a Opti FireStar chipset with an IDE
controller which is Ultra DMA capable (but stable only up to MW-DMA
mode 2). This one *should* be handled by the Linux opti621 driver (I
don't know if it is).

Ciao,
  Dani


