Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSGRP4z>; Thu, 18 Jul 2002 11:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSGRP4z>; Thu, 18 Jul 2002 11:56:55 -0400
Received: from [196.26.86.1] ([196.26.86.1]:14275 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318136AbSGRP4y>; Thu, 18 Jul 2002 11:56:54 -0400
Date: Thu, 18 Jul 2002 18:16:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Dale Amon <amon@vnl.com>
Cc: linux-kernel@vger.kernel.org, Frank Davis <fdavis@si.rr.com>
Subject: Re: 2.5.26 : drivers/scsi/BusLogic.c
In-Reply-To: <20020718154533.GA6851@vnl.com>
Message-ID: <Pine.LNX.4.44.0207181815160.29194-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Dale Amon wrote:

> BusLogic.c:32: #error Please convert me to Documentation/DMA-mapping.txt
> BusLogic.c: In function `BusLogic_DetectHostAdapter':
> BusLogic.c:2841: warning: long unsigned int format, BusLogic_IO_Address_T arg (arg 2)
> BusLogic.c: In function `BusLogic_QueueCommand':
> BusLogic.c:3415: structure has no member named `address'
> BusLogic.c: In function `BusLogic_BIOSDiskParameters':
> BusLogic.c:4141: warning: implicit declaration of function `scsi_bios_ptable'
> BusLogic.c:4141: warning: assignment makes pointer from integer without a cast
> make[2]: *** [BusLogic.o] Error 1

I'm having a look at this, but there seem to be quite a number of 
hindrances. Hopefully i'll have something before next release.

Cheers,
	Zwane Mwaikambo

-- 
function.linuxpower.ca

