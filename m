Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312334AbSCZO3Q>; Tue, 26 Mar 2002 09:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312341AbSCZO3H>; Tue, 26 Mar 2002 09:29:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31251 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312334AbSCZO2y>; Tue, 26 Mar 2002 09:28:54 -0500
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load togeter with heavy network load
To: kschad@correo.e-technik.uni-ulm.de
Date: Tue, 26 Mar 2002 13:44:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203261127.MAA05078@correo.e-technik.uni-ulm.de> from "Kai-Boris Schad" at Mar 26, 2002 12:27:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16prFe-00034f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> harddisks on seperate ide channels but this didn't solve the crashs. 
> It seems to be something with the dma, because if we disable the dma of the 
> harddisks the system is stable. Does anybody also recognise this problem ?
> Is there any solution for this effect ?

I have a large count "via plus lots of disks hangs my computer" mails. I
have a very small count of non via plus lots of disks ..

I don't think its the VIA IDE drivers either - similar reports are seen when
people are doing it with plug in promise cards.

