Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRCFULY>; Tue, 6 Mar 2001 15:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbRCFULO>; Tue, 6 Mar 2001 15:11:14 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:13324
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129446AbRCFULH>; Tue, 6 Mar 2001 15:11:07 -0500
Date: Tue, 6 Mar 2001 12:10:43 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Microsoft ZERO Sector Virus, Result of Taskfile WAR
Message-ID: <Pine.LNX.4.10.10103061206270.13719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

You were correct on your warning tome....

> >McAfee and no vaccine has yet been developed. This
> >virus simply destroys Sector Zero from the hard disk,
> >where vital information for its functioning
> >are stored.

HAHAHA, Microsoft did not listen to me 10 months ago!
I warned then that they had a sercurity hole!

> >This virus acts in the following manner: It sends
> >itself automatically to all contacts on your list
> >with the title "A Virtual Card for You". As >soon as
> >the supposed virtual card is opened, the computer
> >freezes so that the user has to reboot.
> >When the ctrl+alt+del keys or the reset button are
> >pressed, the virus destroys Sector Zero, thus
> >permanently destroying the hard disk.

This is a LIE, it does not destroy the drive, only the partition table.
Please recally the limited effects of "DiskDestroyer" and "SCSIkiller"

This is why we had the flaming discussion about command filters.

Cheers,

Andre Hedrick
Linux ATA Development

