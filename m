Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTFGLsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 07:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTFGLsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 07:48:33 -0400
Received: from u212-239-162-144.adsl.pi.be ([212.239.162.144]:15118 "EHLO
	italy.lashout.net") by vger.kernel.org with ESMTP id S263183AbTFGLsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 07:48:25 -0400
Subject: Re: Using SATA in PATA compatible mode?
From: Adriaan Peeters <apeeters@lashout.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jurgen Kramer <gtm.kramer@inter.nl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054947612.17190.32.camel@dhcp22.swansea.linux.org.uk>
References: <1054932405.2156.5.camel@paragon.slim>
	 <1054947612.17190.32.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1054987313.495.19.camel@bari.lashout.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Jun 2003 14:01:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-07 at 03:00, Alan Cox wrote:

> 	Promise 20376 - Promise have a GPL driver but there are integration
> things to resolve (mostly our end not theirs)

Oh, this would be very good news. As there was no GPL'ed driver for this
chipset, I bought one with a SiI3112 chipset.
Where can this driver be found ? As when I mailed promise about a week
ago, they stated:

> The source code for the SATA chips will not be released, due to
competitive
> reasons. We support the linux distributions of Suse and Redhat mainly.
> 
> A partial open source code will become available in due time, but we do not
> expect that this year.

I hope they changed course :)

It would be nice to have a reference to the drivers in the lkml
archives.

-- 
Adriaan Peeters <apeeters@lashout.net>

