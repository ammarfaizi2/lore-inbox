Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131492AbRAXSGb>; Wed, 24 Jan 2001 13:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132366AbRAXSGW>; Wed, 24 Jan 2001 13:06:22 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:45320 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S131492AbRAXSFq>; Wed, 24 Jan 2001 13:05:46 -0500
Date: Wed, 24 Jan 2001 18:05:43 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: Gregory Maxwell <greg@linuxpower.cx>
cc: Daniel Phillips <phillips@innominate.de>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
In-Reply-To: <20010124082929.A1970@xi.linuxpower.cx>
Message-ID: <Pine.LNX.4.30.0101241805120.30141-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel appears to run fine with this bug() removed.
>
> BTW- gimp and a few other apps also manage to trigger it..

You can add sane with an advansys scsi card and various scsi scanners to
that list

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

Justice is incidental to law and order.
                -- J. Edgar Hoover

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
