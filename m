Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269811AbRHTLDt>; Mon, 20 Aug 2001 07:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269825AbRHTLDj>; Mon, 20 Aug 2001 07:03:39 -0400
Received: from [203.161.228.202] ([203.161.228.202]:17933 "EHLO
	spf1.hq.outblaze.com") by vger.kernel.org with ESMTP
	id <S269811AbRHTLDY>; Mon, 20 Aug 2001 07:03:24 -0400
Date: Mon, 20 Aug 2001 19:13:59 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Cliff Albert <cliff@oisec.net>, linux-kernel@vger.kernel.org,
        gibbs@scsiguy.com
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820191359.A17545@outblaze.com>
In-Reply-To: <20010820185656.A17435@outblaze.com> <E15Ymji-0005ph-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15Ymji-0005ph-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 20, 2001 at 11:56:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > There is a known BIOS irq routing table problem with a large number of Intel
> > > BIOS boards with onboard adaptec controllers. The fact that making it use
> > > the io-apic works suggest this is the same thing.
> > 
> > But 2.4.8 and 2.4.9 work without using io-apic. 
> 
> I'm not currently sure what that proves. Is your board intel bios ?

The BIOS is Phoenix (4,0 Release 6.0, BIOS Build 125). Does Intel
provide their own branded bios ? Never seen them. The box is an ISP 2150
and it is of the Slot 1 variant.

The adaptec bios version is 2.20S1B1

-- 
Yusuf Goolamabbas
yusufg@outblaze.com
