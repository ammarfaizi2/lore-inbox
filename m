Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272244AbRIEScM>; Wed, 5 Sep 2001 14:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272261AbRIEScC>; Wed, 5 Sep 2001 14:32:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44551 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272257AbRIESbu>; Wed, 5 Sep 2001 14:31:50 -0400
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
To: cfriesen@nortelnetworks.com (Christopher Friesen)
Date: Wed, 5 Sep 2001 19:34:18 +0100 (BST)
Cc: matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        wietse@porcupine.org (Wietse Venema),
        linux-kernel@vger.kernel.org (Linux-Kernel mailing list),
        linux-net@vger.kernel.org
In-Reply-To: <3B966E19.3B9B10B4@nortelnetworks.com> from "Christopher Friesen" at Sep 05, 2001 02:25:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ehVC-0006Rx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > the mask for the requested address. This doesn't matter as long as
> > eth0:0-style aliases are configured with ifconfig, but it does matter as
> > soon as ip comes into play and both addresses are assigned to eth0
> > rather than eth0 and eth0:0.
> 
> I think the silence you are hearing from the lkml is a bunch of people thinking
> "Oh, crap!".

Actually its probably a bunch of people thinking "I wonder if someone else
forwarded this to netdev@oss.sgi.com"
