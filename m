Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132877AbRDIXip>; Mon, 9 Apr 2001 19:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132879AbRDIXie>; Mon, 9 Apr 2001 19:38:34 -0400
Received: from jalon.able.es ([212.97.163.2]:56224 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132877AbRDIXi3>;
	Mon, 9 Apr 2001 19:38:29 -0400
Date: Tue, 10 Apr 2001 00:45:11 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Vivek Dasmohapatra <vivek@etla.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Studt <jim@federated.com>,
        linux-kernel@vger.kernel.org
Subject: Re: aic7xxx and 2.4.3 failures
Message-ID: <20010410004511.A7150@werewolf.able.es>
In-Reply-To: <E14mi85-0002pu-00@the-village.bc.nu> <Pine.LNX.4.10.10104092331350.30837-100000@www.teaparty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.10.10104092331350.30837-100000@www.teaparty.net>; from vivek@etla.org on Tue, Apr 10, 2001 at 00:33:29 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.10 Vivek Dasmohapatra wrote:
> On Mon, 9 Apr 2001, Alan Cox wrote:
> 
> > > A typical startup with 6.1.9 proceeds like this...  (6.1.10 hangs silently
> > > after emitting the scsi0 and scsi1 adapter summaries, maybe it is
> > > going through the same gyrations silently.) 
> > 
> > Try saying N to the AIC7xxx driver and Y to AIC7XXX_OLD and see if that
> works.
> 
> I had similar problems w. 2.4.3 on an SMP aic7xx PII, box: new driver
> never managed to mount the root partition - always panicked first. Old
> driver worked fine. 
> 

I am using 2.4.3-ac3 successfully with 6.1.8, 9 and 10, and now building
with 11.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac3 #1 SMP Thu Apr 5 00:28:45 CEST 2001 i686

