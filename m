Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSHPI0T>; Fri, 16 Aug 2002 04:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317078AbSHPI0T>; Fri, 16 Aug 2002 04:26:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56594 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S317063AbSHPI0S>; Fri, 16 Aug 2002 04:26:18 -0400
Message-Id: <200208160824.g7G8Ogp24070@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Christian Reis <kiko@async.com.br>
Subject: Re: General network slowness on SIS 530 with eepro100
Date: Fri, 16 Aug 2002 11:21:33 -0200
X-Mailer: KMail [version 1.3.2]
Cc: eepro100@scyld.com, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20020813212923.L2219@blackjesus.async.com.br> <200208150844.g7F8iQp19827@Port.imtp.ilyichevsk.odessa.ua> <20020815162155.L30462@blackjesus.async.com.br>
In-Reply-To: <20020815162155.L30462@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 August 2002 17:21, Christian Reis wrote:
> On Thu, Aug 15, 2002 at 11:41:20AM -0200, Denis Vlasenko wrote:
> > On 13 August 2002 22:29, Christian Reis wrote:
> > > On tri, which is the referred SIS530 box, as you can see, for most runs
> > > the CPU usage is just so much higher than minas, which has practically
> > > the same setup: K6-500, old PCI (no AGP) board, eepro100 card. I'm
> > > wondering if anybody has seen something like this before?
> >
> > Start swapping hardware between these two boxes
>
> I've done it, actually. I've swapped processor, memory and video cards
> (which are the only things the boxes actually contain) and there has
> been no change. It's very strange - block read and block write consume
> enormous amounts of CPU, no matter how much I tinker. I've tried 2.4.19,
> 2.2.21, NFS patches, etc.

Network card?
Motherboard? :-)
BIOS? 8-)

Compare BIOS/chipset setup (lspci -vvvxxx)
--
vda
