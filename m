Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTJIV0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTJIV0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:26:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17662 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262591AbTJIV0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:26:10 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
Subject: Re: Serverworks CSB5 IDE-DMA Problem (2.4 and 2.6)
Date: Thu, 9 Oct 2003 23:29:00 +0200
User-Agent: KMail/1.5.4
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310091634330.3040-100000@logos.cnet> <200310092313.05371.bzolnier@elka.pw.edu.pl> <3F85D17D.2090006@madness.at>
In-Reply-To: <3F85D17D.2090006@madness.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310092329.00445.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.18, 2.4.19 w/o APIC and ACPI

On Thursday 09 of October 2003 23:22, Stefan Kaltenbrunner wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >>>These "timeout due to drive busy" needs to be resolved.
> >>
> >>Yes - I really hope this will be fixed soon. I was forced to add a
> >>fiberchannel HBA into this maschine today to integrate it into our SAN
> >>to get the database up to speed again.
> >>However I'm willing to move the database to the local disks again if you
> >>want me to test a patch or something along that line.
> >
> > Did some kernel worked okay or this is new system?
>
> This is a new system - I can try an older kernel if you can give me some
> hints about how old it should be :-)
>
> Stefan

