Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271751AbRHUSpL>; Tue, 21 Aug 2001 14:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271822AbRHUSpF>; Tue, 21 Aug 2001 14:45:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27397 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271751AbRHUSoo>; Tue, 21 Aug 2001 14:44:44 -0400
Subject: Re: Qlogic/FC firmware
To: jes@sunsite.dk (Jes Sorensen)
Date: Tue, 21 Aug 2001 19:47:22 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        linux-kernel@vger.kernel.org
In-Reply-To: <d3itfh8j13.fsf@lxplus015.cern.ch> from "Jes Sorensen" at Aug 21, 2001 06:39:04 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZGYc-0008SM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> >> If the firmware was out of date, update it to a known "Qlogic stamp
> >> of approval" version.
> 
> Alan> That requires sorting licensing out with Qlogic. I've talked to
> Alan> them usefully about other stuff so I'll pursue it for a seperate
> Alan> firmware loader module.
> 
> Well getting firmware out of them tends to be up and down.
> 
> However I just looked through the QLogic v4.27 provided driver from
> their web site and it does in fact included firmware with a GPL
> license.
> 
> Dave, if you want to play with this and stick it into the qlogicfc.c
> driver then you will at least have something that sorta works for now
> (module all the other problems with that driver).
> 
> http://www.qlogic.com/bbs-html/csg_web/adapter_pages/driver_pages/22xx/22linux.html
> 
> They do have a stupid 'read and agree' license in front of that page
> if you go in via the official qlogic.com door, however if the code
> inside is GPL then I asume it's GPL.
> 
> Cheers
> Jes
> 

