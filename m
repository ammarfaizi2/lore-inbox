Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbTIMKhq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 06:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTIMKhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 06:37:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4828 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262122AbTIMKho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 06:37:44 -0400
Date: Sat, 13 Sep 2003 12:37:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913103738.GB27368@fs.tum.de>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se> <20030907174341.GA21260@mail.jlokier.co.uk> <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk> <20030911062816.GX27368@fs.tum.de> <1063290309.2962.12.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063290309.2962.12.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 03:25:10PM +0100, Alan Cox wrote:
> On Iau, 2003-09-11 at 07:28, Adrian Bunk wrote:
> > - Does the Cyrix III support 686 instructions?
> 
> Original Cyrix III supports the IA32 P6 definition
> VIA C3 supports the IA32 P6 definition
> The later ones also support cmov (the gcc i686 definition)
>...

Ah, thanks.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

