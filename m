Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRHTKqr>; Mon, 20 Aug 2001 06:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbRHTKqi>; Mon, 20 Aug 2001 06:46:38 -0400
Received: from [203.161.228.202] ([203.161.228.202]:56332 "EHLO
	spf1.hq.outblaze.com") by vger.kernel.org with ESMTP
	id <S266263AbRHTKqW>; Mon, 20 Aug 2001 06:46:22 -0400
Date: Mon, 20 Aug 2001 18:56:56 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Cliff Albert <cliff@oisec.net>, linux-kernel@vger.kernel.org,
        gibbs@scsiguy.com
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820185656.A17435@outblaze.com>
In-Reply-To: <20010820105520.A22087@oisec.net> <E15YmR3-0005mb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15YmR3-0005mb-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 20, 2001 at 11:37:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > With 2.4.8-ac7, I get SCSI errors and the kernel fails to boot. If I
> > > compile with APIC enabled and APIC on UP also enabled, it boots
> > > cleanly
> > 
> > I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
> > the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
> > i've been getting these errors since 2.4.3.
> 
> There is a known BIOS irq routing table problem with a large number of Intel
> BIOS boards with onboard adaptec controllers. The fact that making it use
> the io-apic works suggest this is the same thing.

But 2.4.8 and 2.4.9 work without using io-apic. 

-- 
Yusuf Goolamabbas
yusufg@outblaze.com
