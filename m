Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316827AbSGVL7H>; Mon, 22 Jul 2002 07:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGVL7H>; Mon, 22 Jul 2002 07:59:07 -0400
Received: from [196.26.86.1] ([196.26.86.1]:2794 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316827AbSGVL7H>; Mon, 22 Jul 2002 07:59:07 -0400
Date: Mon, 22 Jul 2002 14:20:00 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Thunder from the hill <thunder@ngforever.de>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>,
       "C.L. Huang" <ching@tekram.com.tw>
Subject: Re: Tekram DC390 DMA allocation fixes
In-Reply-To: <Pine.LNX.4.44.0207220424130.3309-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0207221419130.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Thunder from the hill wrote:

> On Mon, 22 Jul 2002, Kurt Garloff wrote:
> > I believe we should just use
> > pci_map_single/_sg and sg_dma_address(), no?
> > 
> > Or are they scheduled for removal ... ?
> 
> No, I just forgot about them, that's all...

Ah but do note that virt_to_bus and bus_to_virt are scheduled for removal

	Zwane

-- 
function.linuxpower.ca

