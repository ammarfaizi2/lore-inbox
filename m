Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTILUlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTILUlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:41:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7678 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261872AbTILUlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:41:50 -0400
Date: Fri, 12 Sep 2003 22:41:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030912204141.GQ27368@fs.tum.de>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se> <20030907174341.GA21260@mail.jlokier.co.uk> <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk> <20030911062816.GX27368@fs.tum.de> <20030911110435.GA1225@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911110435.GA1225@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 12:04:35PM +0100, Dave Jones wrote:
> On Thu, Sep 11, 2003 at 08:28:16AM +0200, Adrian Bunk wrote:
> 
>  > - Does the Cyrix III support 686 instructions?
> 
> Depends on your definition of 686. If you follow the Intel
> definition (where CMOV is optional), yes. If you follow the gcc
> definition (where CMOV is assumed), no.
> Except for the latest Nehemiah cores (which now have CMOV).
>...

Thanks for this information.

Since I'm looking for the options to pass to gcc I have to follow the 
gcc definition...

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

