Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135559AbRDTAaa>; Thu, 19 Apr 2001 20:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135577AbRDTAaV>; Thu, 19 Apr 2001 20:30:21 -0400
Received: from jalon.able.es ([212.97.163.2]:57537 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S135559AbRDTAaG>;
	Thu, 19 Apr 2001 20:30:06 -0400
Date: Fri, 20 Apr 2001 02:29:57 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Udo A . Steinberg" <reality@delusion.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ac10 ide-cd oopses on boot
Message-ID: <20010420022957.A1054@werewolf.able.es>
In-Reply-To: <E14qNWF-0008Jc-00@the-village.bc.nu> <3ADF802A.1043DB0F@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3ADF802A.1043DB0F@delusion.de>; from reality@delusion.de on Fri, Apr 20, 2001 at 02:17:46 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.20 Udo A. Steinberg wrote:
> Alan Cox wrote:
> > 
> > > Just built 2.4.3-ac10 and got an oops when booting. It tries to detect
> > > the CD and gives the oops.
> 
> I'm getting a similar oops with -ac10. I initially thought this might be
> a result of switching to gcc-2.95.3, because -ac9 runs fine when built
> with gcc-2.95.2, but if others have seen this too, it's probably the
> cdrom code indeed.
> 

Mine is built with gcc-2.96-0.48mdk.

--
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac9 #1 SMP Wed Apr 18 10:35:48 CEST 2001 i686

