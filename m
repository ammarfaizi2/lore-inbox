Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272507AbTHKL3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 07:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272508AbTHKL3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 07:29:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50910 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272507AbTHKL3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 07:29:44 -0400
Date: Mon, 11 Aug 2003 13:28:52 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
cc: Andrew Morton <akpm@osdl.org>, Benjamin Weber <shawk@gmx.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BUG mm-tree of test2/test3] nforce2-acpi-fixes breaks via ide
 controller
In-Reply-To: <200308111017.23100.adq_dvb@lidskialf.net>
Message-ID: <Pine.SOL.4.30.0308111326150.11836-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Aug 2003, Andrew de Quincey wrote:

> > > I do not know why it should interfere with my via stuff, but it does. A
> > > vanilla test3 kernel is working fine as well, whereas test3-mm1 shows
> > > the same error as before with test2-mmX.
> >
> > Me either.  Unfortunately that patch does five different things so we
> > cannot easily narrow it down further.
>
> Yeah, I know. My next patch is likely to have to do even more unfortunately.
> Found quite a number more issues with IRQs.

Split it on logical changes if its possible.

--bartlomiej

