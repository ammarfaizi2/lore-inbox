Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSE2NxJ>; Wed, 29 May 2002 09:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSE2NxI>; Wed, 29 May 2002 09:53:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51189 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315275AbSE2NxH>; Wed, 29 May 2002 09:53:07 -0400
Subject: Re: odd timer bug, similar to VIA 686a symptoms
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neale Banks <neale@lowendale.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10205292342150.3388-100000@marina.lowendale.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 15:55:56 +0100
Message-Id: <1022684156.9255.215.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 14:47, Neale Banks wrote:
> Straight from the metaphorical horses's virtual mouth:
> 
> gull:~# lspci 
> 00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1451 (rev ad)
> 00:02.0 Non-VGA unclassified device: Acer Laboratories Inc. [ALi] M1449 (rev b2)
> 00:06.0 VGA compatible controller: Chips and Technologies F65545
> 00:07.0 IDE interface: CMD Technology Inc PCI0640 (rev 02)
> 
> Is the "[ALi] M1451" and "[ALi] M1449" are what we are looking for here?

Yes - thanks.

