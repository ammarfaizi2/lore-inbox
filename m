Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRDDTX1>; Wed, 4 Apr 2001 15:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRDDTXR>; Wed, 4 Apr 2001 15:23:17 -0400
Received: from [64.64.109.142] ([64.64.109.142]:14606 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131958AbRDDTXN>; Wed, 4 Apr 2001 15:23:13 -0400
Message-ID: <3ACB7438.D1A233A7@didntduck.org>
Date: Wed, 04 Apr 2001 15:21:28 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Cornelis <Frank.Cornelis@rug.ac.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.3 crashed my hard disk
In-Reply-To: <Pine.GSO.4.10.10104042028270.13922-100000@eduserv2.rug.ac.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Cornelis wrote:
> 
> Hey,
> 
> After I did put in /etc/sysconfig/harddisks
>         USE_DMA=1
> my system did crash very badly, I guess after my hard disks did wake up
> again. For I while I though I'd lose some sectors because of this, I had
> to re-install my RedHat 7.0, had a not so productive day :) But, hard
> disks are OK now.
> I thought I should report this.
> Below there is a copy of my dmesg log.
> 
> BTW: my motherboard runs at 112 Mhz, overclocked, was 100 Mhz.
> Been running this configuration over more than 2 years now without such
> major problems.
> Could this be the cause?
> 
> Frank.

http://www.tux.org/lkml/#s13-3

--

				Brian Gerst
