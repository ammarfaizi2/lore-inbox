Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbRARIqM>; Thu, 18 Jan 2001 03:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130355AbRARIpx>; Thu, 18 Jan 2001 03:45:53 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:36368
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129798AbRARIpq>; Thu, 18 Jan 2001 03:45:46 -0500
Date: Thu, 18 Jan 2001 00:45:13 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: File System Corruption with 2.2.18
In-Reply-To: <20010118103809.P1265@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.10.10101180043200.20569-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But it works on all ATA disks? Does it work for SCSI as well?

The KIOBUFS version may, but not the taskfile version.

> I think it would be cool if you'd make it available (on linux-ide.org?),
> so that people install servers (and anybody who _cares_) could test their
> hardware/driver combination before starting using the box.

who is going to ship install images with this kernel code added and the
most dangerous feature ever create eanble?

> Now we have memtest86, cpuburn (what more). It would be nice to have a
> good (if not complete) test set to run on each new linux box. It's not
> nice to use the box for a month and then go "f..., this box has faulty
> memory!" or ..."faulty disk!". Yes, that's what's happened to all of us.
> 
> It's much nicer to get a warranty replacement, when you don't have any
> data on the disk.

It can do that without a file system also.... ;-)

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
