Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRAQX5r>; Wed, 17 Jan 2001 18:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbRAQX5i>; Wed, 17 Jan 2001 18:57:38 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:1031 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S129830AbRAQX51>; Wed, 17 Jan 2001 18:57:27 -0500
Date: Wed, 17 Jan 2001 23:57:23 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: Andre Hedrick <andre@linux-ide.org>
cc: Vojtech Pavlik <vojtech@suse.cz>, Terrence Martin <tmartin@cal.montage.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: File System Corruption with 2.2.18
In-Reply-To: <Pine.LNX.4.10.10101171443300.19379-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0101172356370.26536-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi!
> >
> > Cute. Can it be run on say a swap partition?
>
> maybe but why?

Because it stores no data, hence the wiping out of it is no problem?

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

The only function of economic forecasting is to make astrology look
respectable.
                -- John Kenneth Galbraith

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
