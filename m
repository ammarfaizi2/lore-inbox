Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRDDS74>; Wed, 4 Apr 2001 14:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRDDS7r>; Wed, 4 Apr 2001 14:59:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22031 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131191AbRDDS73>; Wed, 4 Apr 2001 14:59:29 -0400
Subject: Re: linux 2.4.3 crashed my hard disk
To: Frank.Cornelis@rug.ac.be (Frank Cornelis)
Date: Wed, 4 Apr 2001 20:00:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, Frank.Cornelis@rug.ac.be
In-Reply-To: <Pine.GSO.4.10.10104042028270.13922-100000@eduserv2.rug.ac.be> from "Frank Cornelis" at Apr 04, 2001 08:43:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ksW8-0002Y7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After I did put in /etc/sysconfig/harddisks 
> 	USE_DMA=1
> my system did crash very badly, I guess after my hard disks did wake up

So you forced DMA on

> BTW: my motherboard runs at 112 Mhz, overclocked, was 100 Mhz.

and ran overclocked

> Been running this configuration over more than 2 years now without such
> major problems.
> Could this be the cause?

Quite possibly. There are reasons we ignore bug reports from overclockers

