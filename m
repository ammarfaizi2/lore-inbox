Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318415AbSGYJZp>; Thu, 25 Jul 2002 05:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318417AbSGYJZp>; Thu, 25 Jul 2002 05:25:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19706 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318415AbSGYJZo>; Thu, 25 Jul 2002 05:25:44 -0400
Subject: RE: 2.5.28 and partitions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt_Domsch@Dell.com
Cc: viro@math.psu.edu, Andries.Brouwer@cwi.nl,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <F44891A593A6DE4B99FDCB7CC537BBBBB8394A@AUSXMPS308.aus.amer.dell.com>
References: <F44891A593A6DE4B99FDCB7CC537BBBBB8394A@AUSXMPS308.aus.amer.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 11:42:09 +0100
Message-Id: <1027593729.9488.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 04:22, Matt_Domsch@Dell.com wrote:
> Absolutely.  A single external disk pod with 14 73GB SCSI disks is >1TB,
> with 145GB disks expected in the very near future, and 120GB IDE disks
> available today.  You can put 4 disk pods on a single 4-channel RAID

With 3ware cards I know multiple people using 2 8 port 3ware cards each
with 8 160Gb IDE disks on it. These are now extremely cheap systems to
build, especially if you buy the 3ware cards carefully and don't believe
the list prices.

> > ... and still use i386 with these disks?  
> 
> Yep.  We're doing all of this today on our x86 server products, and don't
> expect x86 to die any time soon.  I'm on conference calls each week with

I can point to multiple people doing this. Everything from video data
vaults to archives of scanned document images. Right now they have to
split the arrays up, but as the disks get bigger and cheaper that is
going to become a pain

