Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTFGL6G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 07:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTFGL6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 07:58:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5780 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263150AbTFGL6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 07:58:05 -0400
Date: Sat, 7 Jun 2003 14:11:14 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jurgen Kramer <gtm.kramer@inter.nl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using SATA in PATA compatible mode?
In-Reply-To: <1054947612.17190.32.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0306071409340.20172-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Jun 2003, Alan Cox wrote:

> On Gwe, 2003-06-06 at 21:46, Jurgen Kramer wrote:
> > I've read somewhere that the SATA controllers are backward compatible
> > with PATA controllers. Does this mean that a SATA controller can be used
> > with standard PATA drivers (especially the Intel ICH5)?
>
> I'm not totally sure about the status of the SATA on the Intel right
> now. I was under the impression it was very similar to the PATA.
>
> For some of the others its a bit variable:
> 	HPT some people report work some dont
> 	Promise 20376 - Promise have a GPL driver but there are integration

GPL driver from Promise?!!?

> things to resolve (mostly our end not theirs)
> 	SI 3112 - Now works well with almost all drives.
> 	3Ware SATA raid - works

