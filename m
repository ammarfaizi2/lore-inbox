Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132361AbRARIwf>; Thu, 18 Jan 2001 03:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132360AbRARIwZ>; Thu, 18 Jan 2001 03:52:25 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:53014 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S132035AbRARIwQ>; Thu, 18 Jan 2001 03:52:16 -0500
Date: Thu, 18 Jan 2001 10:52:01 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Ville Herva <vherva@mail.niksula.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: File System Corruption with 2.2.18
Message-ID: <20010118105201.N34162@niksula.cs.hut.fi>
In-Reply-To: <20010118103809.P1265@niksula.cs.hut.fi> <Pine.LNX.4.10.10101180043200.20569-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101180043200.20569-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Jan 18, 2001 at 12:45:13AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 12:45:13AM -0800, you [Andre Hedrick] claimed:
> 
> > But it works on all ATA disks? Does it work for SCSI as well?
> 
> The KIOBUFS version may, but not the taskfile version.

Ok.
 
> > I think it would be cool if you'd make it available (on linux-ide.org?),
> > so that people install servers (and anybody who _cares_) could test their
> > hardware/driver combination before starting using the box.
> 
> who is going to ship install images with this kernel code added and the
> most dangerous feature ever create eanble?

I don't think any vendor has to ship it. The memtest86 suite is available
as a floppy image, the harddisk tester could be as well. (Of course with a
LARGE alert saying "THIS *DESTROYS* ALL YOUR HARDDISK CONTENTS, please
unplug everyting you don't want tested to be sure".

> > Now we have memtest86, cpuburn (what more). It would be nice to have a
> > good (if not complete) test set to run on each new linux box. It's not
> > nice to use the box for a month and then go "f..., this box has faulty
> > memory!" or ..."faulty disk!". Yes, that's what's happened to all of us.
> > 
> > It's much nicer to get a warranty replacement, when you don't have any
> > data on the disk.
> 
> It can do that without a file system also.... ;-)

Yes.


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
