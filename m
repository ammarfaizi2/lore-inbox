Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRC2DlB>; Wed, 28 Mar 2001 22:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132657AbRC2Dkl>; Wed, 28 Mar 2001 22:40:41 -0500
Received: from Mail.Mankato.MSUS.EDU ([134.29.1.12]:42504 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id <S132655AbRC2Dki>;
	Wed, 28 Mar 2001 22:40:38 -0500
Message-ID: <3AC2AE64.2B14FFAA@mnsu.edu>
Date: Wed, 28 Mar 2001 21:39:16 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Organization: Minnesota State University, Mankato
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux-2.4.2-ac27 - read on /proc/bus/pci/devices never finishes 
 after rmmod aic7xxx
In-Reply-To: <200103290320.f2T3KNs02696@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aic7xxx_osm.h:#define AIC7XXX_DRIVER_VERSION  "6.1.5"


"Justin T. Gibbs" wrote:

> >Hello,
> >
> >I'm using Linux-2.4.2-ac27 SMP compiled with gcc version 2.95.2 20000220
> >(Debian GNU/Linux).
>
> What version of the aic7xxx driver is embedded in 2.4.2-ac27?  This
> particular issue was fixed just after 6.1.5 was released.
>
> --
> Justin

