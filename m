Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129409AbRBAIhd>; Thu, 1 Feb 2001 03:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbRBAIhY>; Thu, 1 Feb 2001 03:37:24 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:12562
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129409AbRBAIhO>; Thu, 1 Feb 2001 03:37:14 -0500
Date: Thu, 1 Feb 2001 00:23:33 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rupa Schomaker <rupa-list+linux-kernel@rupa.com>
cc: Andries.Brouwer@cwi.nl, mlord@pobox.com, ole@linpro.no,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <m3hf2fdjl7.fsf@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10102010022070.15351-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 2001, Rupa Schomaker wrote:

> But now it doesn't matter.  The drive was tainted (fdisk run while
> attached to the mainboard controller) and now that geometry is
> "stuck".  <shrug>  I was mostly explaining why it is nice to get the
> same geometry on two identical drives (RAID1 is easier for the human
> to deal with).

It doesn't but I got out of the geometry business two+ years ago...
Andries (Mr. FDisk) Brouwer is the man......

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
