Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSGPLBx>; Tue, 16 Jul 2002 07:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSGPLBw>; Tue, 16 Jul 2002 07:01:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4601 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S314395AbSGPLBv>; Tue, 16 Jul 2002 07:01:51 -0400
Date: Tue, 16 Jul 2002 13:04:37 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan Marek <linux@hazard.jcu.cz>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk freeze in the 2.5.24
In-Reply-To: <20020716095159.GA526@hazard.jcu.cz>
Message-ID: <Pine.SOL.4.30.0207161301520.3340-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Jul 2002, Jan Marek wrote:

> Hallo,
>
> On Fri, Jul 12, 2002 at 04:02:09PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >
> > Already fixed, please apply all patches from:
> >
> > http://home.elka.pw.edu.pl/~bzolnier/ata/
>
> thank you... But when I aplied this patches, I cannot compile tcq.c??? I
> applied this patches against vanilla 2.5.25 kernel source...

TCQ compilation is already fixed and will be in next kernel.

Regards
--
Bartlomiej

