Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbSJDLFt>; Fri, 4 Oct 2002 07:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSJDLFt>; Fri, 4 Oct 2002 07:05:49 -0400
Received: from 62-190-202-48.pdu.pipex.net ([62.190.202.48]:26887 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261554AbSJDLFr>; Fri, 4 Oct 2002 07:05:47 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210041112.g94BCLLQ002034@darkstar.example.net>
Subject: Re: RAID backup
To: illtud.daniel@llgc.org.uk (Illtud Daniel)
Date: Fri, 4 Oct 2002 12:12:21 +0100 (BST)
Cc: enorwood@effrem.com, kanoa@cfht.hawaii.edu, roy@karlsbakk.net,
       jakob@unthought.net, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
In-Reply-To: <3D9D6C84.F1736E15@llgc.org.uk> from "Illtud Daniel" at Oct 04, 2002 11:25:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In addition, HSM software costs
> > something (even if you write it yourself) on top of the tape infrastructure.
> > One customer of ours was quoted 40K per TB of HSM *software* alone.
> 
> I've got 25TB uncompressed of HSM here, and it's cost us (ex VAT)
> roughly:
> 
> £10k for the first 1.6TB (on NT, DLT library)
> £18k for the next  6.0TB (on NT, LTO library)
> £45k for the next 18.0TB (on Solaris, LTO Library)
> 
> ..for the software licencing alone. Plus about 10% pa. in support
> costs.
> You're looking at about 50-60% of the library cost for the HSM software
> to manage it (tapes are another thing). Is HSM really that difficult?
> 
> It really is a racket, but it's not so much compared with the
> cost of re-producing the data (mainly digitized collections).
> I'd be happier about it if they were more reliable (libs and s/w).
> Disk arrays, on the other hand, would cost us a fortune in
> upgrading the cooling - we've had to do this once just because of
> the 3-4 TB of online storage we've got, and adding huge exchangers
> (and associated pipes) isn't something I want to do much of.
> 
> Oh, and having spent much of last night and this morning dealing
> with multiple SCSI disk failures, and having seen about 5% of
> ours fail in a year, I'm rapidly seeing the light on IDE.

This is rapidly becoming off topic, especially for the kernel dev list, which is why I originally just posted the following info to the cc'ed people, but since it might be of interest, I'm posting it to the lists:

Sony GY-8240-DTF2 tape drive, picture of it, with some info here:

http://www.tomtec.co.jp/english/tape_hisped.html

this uses similar technology to that which is used in their Digital Betacam(tm) studio VCRs, and stores 200 Gigs uncompressed on one large tape, (60 on a small tape).

Data rate, 24 MB/s.

You've got to have a lot of data for that to be insufficient, and it would be my backup system of choice, if I needed the capcity, (I currently use punched Myler tape :-) ).

John.
