Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSGVKVj>; Mon, 22 Jul 2002 06:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSGVKVi>; Mon, 22 Jul 2002 06:21:38 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:35818 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S316629AbSGVKVh>; Mon, 22 Jul 2002 06:21:37 -0400
Date: Mon, 22 Jul 2002 04:24:34 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Kurt Garloff <garloff@suse.de>
cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>,
       "C.L. Huang" <ching@tekram.com.tw>
Subject: Re: Tekram DC390 DMA allocation fixes
In-Reply-To: <20020722093341.GA32278@nbkurt.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.44.0207220424130.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 22 Jul 2002, Kurt Garloff wrote:
> I believe we should just use
> pci_map_single/_sg and sg_dma_address(), no?
> 
> Or are they scheduled for removal ... ?

No, I just forgot about them, that's all...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

