Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSLACGV>; Sat, 30 Nov 2002 21:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSLACGV>; Sat, 30 Nov 2002 21:06:21 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:45979 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261375AbSLACGV>; Sat, 30 Nov 2002 21:06:21 -0500
Subject: Re: scx200_gpio.c doesn't compile in 2.5.50
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christer Weinigel <wingel@nano-system.com>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87of86hdvg.fsf@zoo.weinigel.se>
References: <20021128013527.GU21307@fs.tum.de> 
	<87of86hdvg.fsf@zoo.weinigel.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Dec 2002 02:45:33 +0000
Message-Id: <1038710733.18752.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-30 at 22:49, Christer Weinigel wrote:
> Adrian Bunk <bunk@fs.tum.de> writes:
> 
> > Compilation of drivers/char/scx200_gpio.c fails in 2.5.50 with the error
> > messages below.
> 
> Thanks for the report.  Patch follows.
> 
> Alan, do you want small fixes like these or should I send them to
> someone else?


Compile fixes are good to have, especially small ones

