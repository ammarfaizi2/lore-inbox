Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRHTKyS>; Mon, 20 Aug 2001 06:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbRHTKyI>; Mon, 20 Aug 2001 06:54:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44550 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267852AbRHTKxv>; Mon, 20 Aug 2001 06:53:51 -0400
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
To: yusufg@outblaze.com (Yusuf Goolamabbas)
Date: Mon, 20 Aug 2001 11:56:50 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), cliff@oisec.net (Cliff Albert),
        linux-kernel@vger.kernel.org, gibbs@scsiguy.com
In-Reply-To: <20010820185656.A17435@outblaze.com> from "Yusuf Goolamabbas" at Aug 20, 2001 06:56:56 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ymji-0005ph-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There is a known BIOS irq routing table problem with a large number of Intel
> > BIOS boards with onboard adaptec controllers. The fact that making it use
> > the io-apic works suggest this is the same thing.
> 
> But 2.4.8 and 2.4.9 work without using io-apic. 

I'm not currently sure what that proves. Is your board intel bios ?

